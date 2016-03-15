<?php
namespace Casebox\CoreBundle\Service\Auth;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Traits\TranslatorTrait;
use League\OAuth2\Client\Provider\Google;
use Symfony\Component\HttpFoundation\Session\Session;

/**
 * Class Oauth2Utils
 */
class Oauth2Utils
{
    use TranslatorTrait;

    /**
     * @param array $GPlus
     *
     * @return Google
     */
    public static function getGoogleProvider($GPlus = null)
    {
        if (empty($GPlus)) {
            $GPlus = static::getGoogleConfig();
        }

        $provider = null;
        if (
            isset($GPlus['web']) &&
            isset($GPlus['web']['client_id']) &&
            isset($GPlus['web']['client_secret']) &&
            isset($GPlus['web']['redirect_uris']) &&
            count($GPlus['web']['redirect_uris'])
        ) {
            //require_once realpath(__DIR__.'/../../../vendor/').'/autoload.php';

            $provider = new Google(
                [
                    'clientId' => $GPlus['web']['client_id'],
                    'clientSecret' => $GPlus['web']['client_secret'],
                    'redirectUri' => $GPlus['web']['redirect_uris'][0],
                ]
            );
        }

        return $provider;
    }

    /**
     * @return array
     */
    public static function getGoogleConfig()
    {
        $useGoogleOauth2_json = Config::get('oauth2_credentials_google');
        if ($useGoogleOauth2_json && $GPlus = Util\jsonDecode($useGoogleOauth2_json)) {
            return $GPlus;
        }

        return null;
    }

    /**
     *
     * @param Google $provider
     *
     * @return string url to login
     */
    public static function getLoginUrl($provider = null)
    {
        $authUrl = null;

        if (isset($provider)) {
            // $generator = $provider->getRandomFactory()->getMediumStrengthGenerator();
            // $random_state = $generator->generateString(32);

            $state = [
                'core' => Config::get('core_name'),
                'state' => session_id(),
            ];

            $authUrl = $provider->getAuthorizationUrl(
                ['state' => strtr(base64_encode(json_encode($state)), '+/=', '-_,')]
            );

            $session = Cache::get('symfony.container')->get('session');
            $session->set('oauth2state', $provider->getState());
        }

        return $authUrl;
    }

    /**
     * Return true if current request is for oaut2callback script
     * @return boolean
     */
    public static function isOauth2Login()
    {
        /** @var Session $session */
        $session = Cache::get('symfony.container')->get('session');
        $oauthState = $session->get('oauth2state');

        return isset($_GET['state']) && isset($oauthState);
    }

    /**
     * @return array
     */
    public static function checkLogged()
    {
        $result = [
            'success' => false,
        ];

        if (static::isOauth2Login()) {
            $state = self::decodeState($_GET['state']);

            $session = Cache::get('symfony.container')->get('session');
            $sessionState = self::decodeState($session->get('oauth2state'));

            if (isset($sessionState['state']) &&
                isset($state['state']) &&
                $sessionState['state'] == $state['state'] &&
                isset($state['email'])
            ) {
                $userId = DM\Users::getIdByEmail($state['email']);

                if (empty($userId)) {
                    $name = self::trans('Specify_username');
                    $result['message'] = 'Email '.$state['email'].' not authorized for this core. '.$name.' ';

                } else {
                    $result = [
                        'success' => true,
                        'user_id' => $userId,
                        'session_id' => $sessionState['state'],
                    ];
                }

            } else {
                $result['message'] = 'WRONG STATE!!!';
            }

        } else {
            $result['message'] = 'Is not Oauth login';
        }

        return $result;
    }

    /**
     * @param Google $provider
     * @param string $state
     * @param string $code
     *
     * @return null
     */
    public static function getToken($provider, $state, $code)
    {
        $token = null;

        if (isset($provider)) {

            if (empty($state)) {
                trigger_error('Oauth2Utils Invalid state: '.$state, E_USER_WARNING);
            } else {
                // Try to get an access token (using the authorization code grant)
                try {
                    $token = $provider->getAccessToken('authorization_code', ['code' => $code]);
                } catch (\Exception $e) {
                    // Failed to get user details
                    trigger_error('Something went wrong: '.$e->getMessage(), E_USER_ERROR);
                }
            }
        }

        return $token;
    }

    /**
     * @param Google $provider
     * @param string $token
     *
     * @return null
     */
    public static function getOwner($provider, $token)
    {

        $ownerDetails = null;

        // Optional: Now you have a token you can look up a users profile data
        try {
            // We got an access token, let's now get the owner details
            $ownerDetails = $provider->getResourceOwner($token);
        } catch (\Exception $e) {
            trigger_error('Something went wrong: '.$e->getMessage(), E_USER_ERROR);
        }

        return $ownerDetails;
    }

    /**
     * @param string $state
     *
     * @return string
     */
    public static function encodeState($state)
    {
        return strtr(base64_encode(json_encode($state)), '+/=', '-_,');
    }

    /**
     * @param string $encodedState
     *
     * @return mixed
     */
    public static function decodeState($encodedState)
    {
        $state_json = base64_decode(strtr($encodedState, '-_,', '+/='));
        $state = json_decode($state_json, true);

        return $state;
    }

    /**
     * @param Google $provider
     * @param string $encodedState
     * @param string $code
     *
     * @return null|string
     */
    public static function getLocalState($provider, $encodedState, $code)
    {
        $updateEncodedState = null;
        $token = static::getToken($provider, $encodedState, $code);

        if (isset($token)) {
            $ownerDetails = static::getOwner($provider, $token);
            $state = static::decodeState($encodedState);
            if ($ownerDetails->getEmail()) {
                $state['email'] = $ownerDetails->getEmail();
                $updateEncodedState = static::encodeState($state);
            }
        }

        return $updateEncodedState;
    }
}
