<?php

namespace Casebox\CoreBundle\Service\Auth;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\User;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class TwoStepAuth
 */
class TwoStepAuth
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * @return Container
     */
    public function getContainer()
    {
        return $this->container;
    }

    /**
     * @param Container $container
     *
     * @return TwoStepAuth $this
     */
    public function setContainer($container)
    {
        $this->container = $container;

        return $this;
    }

    /**
     * @param UsersGroups $user
     * @param string $code
     * @return array|bool
     */
    public function authenticate(UsersGroups $user, $code = null)
    {
        $u = new User();
        $cfg = $u->getTSVConfig();

        // If not enabled 2step auth
        if (empty($cfg['method']) && empty($cfg['sd'])) {
            return $user;
        }

        /** @var GoogleAuth|YubikeyAuth $authenticator */
        $authenticator = $u->getTSVAuthenticator($cfg['method'], $cfg['sd']);
        $auth = $authenticator->verifyCode($code);

        if (!$auth) {
            return [
                'success' => false,
                'message' => is_string($auth) ? htmlspecialchars($auth, ENT_COMPAT) : 'Wrong verification code. Please try again.'
            ];
        }

        return $user;
    }
}
