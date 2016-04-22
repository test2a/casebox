<?php

namespace Casebox\CoreBundle\Service\Auth;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Cache;

/**
 * Class YubikeyAuth
 */
class YubikeyAuth implements AuthInterface
{
    /**
     * Url used to create new secred data
     * this url is used for posting with params: email, otp
     * parsed result should contain new client id and secret key
     * @var string
     */
    const YUBIKEY_URL = 'https://upgrade.yubico.com/getapikey/';

    /**
     * secret data
     * @var string|array
     */
    private $secretData = null;

    /**
     * YubikeyAuth authenticator library class instance
     * @var object
     */
    private $instance = null;

    /**
     * YubikeyAuth constructor
     */
    public function __construct($p = [])
    {
        if (isset($p['clientId']) && isset($p['sk'])) {
            $this->instance = new \Auth_Yubico($p['clientId'], '', 1);

            $this->secretData = $p;
        }
    }

    /**
     * Method for preparing secret data creation.
     * For example google authenticator will generate secret key
     * $params {
     *     email
     *     code
     * }
     * @return array associative array of secret params
     */
    public function prepareSecretDataCreation()
    {
    }

    /**
     * Create secret data
     * $params {
     *     email
     *     code
     * }
     * @return array
     * @throws \Exception
     */
    public function createSecretData($params = null)
    {
        if (!empty($params['clientId']) && !empty($params['sk'])) {
            return $params;
        }

        if (empty($params['email'])) {
            throw new \Exception('Yubico error: Email not specified for secret data creation.', 1);
        }
        if (empty($params['code'])) {
            throw new \Exception('Yubico error: OTP not specified for secret data creation.', 1);
        }

        $data = [
            'email' => $params['email'],
            'otp' => $params['code'],
        ];

        $data = http_build_query($data, '', '&');

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, self::YUBIKEY_URL);
        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        curl_setopt($ch, CURLINFO_HEADER_OUT, 1);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);

        $rez = curl_exec($ch);

        file_put_contents(Config::get('debug_log').'_yubikey', $rez);

        if (curl_errno($ch)) {
            throw new \Exception("curl_error:".curl_error($ch), 1);
        }

        $rez = strip_tags($rez);

        preg_match_all('/client id:[\s]*([\d]+)\s+secret key:[\s]*([^\s]+)/i', $rez, $matches);

        if (empty($matches[1][0]) || empty($matches[2][0])) {
            throw new \Exception('Cannot find Client ID and Secret key on Yubiko response for getting api key.', 1);
        }

        $params['clientId'] = $matches[1][0];
        $params['sk'] = $matches[2][0];

        return $params;
    }

    /**
     * Set secret params
     *
     * @param string|array $secretData Secret data used for code generation
     *
     * @return void
     */
    public function setSecretData($secretData)
    {
        if (
            empty($this->secretData) ||
            ($secretData['clientId'] != $this->secretData['clientId']) ||
            ($secretData['sk'] != $this->secretData['sk'])
        ) {
            $this->instance = new \Auth_Yubico($secretData['clientId'], '', 1);
        }
        $this->secretData = $secretData;
    }

    /**
     * Return the secret params
     *
     * @return string|array
     */
    public function getSecretData()
    {
        return $this->secretData;
    }

    /**
     * function to return data used for message displayed to user when enabling TSV.
     * @return array
     */
    public function getTemplateData()
    {
        $rez = ['email' => @Cache::get('session')->get('user')['email']];

        return $rez;
    }

    /**
     * Return a generated code (otp). Used by Google Authenticatot for sending the code over sms.
     *
     * @return string
     */
    public function getCode()
    {
        return null;
    }

    /**
     * Verify a given code
     *
     * @param  string $code one tyme password
     *
     * @return bool
     */
    public function verifyCode($code)
    {
        $rez = true;

        if (substr($this->secretData['code'], 0, 12) != substr($code, 0, 12)) {
            $rez = false;
        } else {
            try {
                $this->instance->verify($code);
            } catch (\Exception $e) {
                $rez = false;
                Cache::get('symfony.container')->get('logger')->error($e->getMessage());
            }
        }

        return $rez;
    }
}
