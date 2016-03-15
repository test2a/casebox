<?php
namespace Casebox\CoreBundle\Service\WebDAV;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\Auth\CaseboxAuth;
use Casebox\CoreBundle\Service\Cache;
use Symfony\Component\HttpFoundation\Session\Session;

/**
 * Class Auth
 */
class Auth extends \Sabre\DAV\Auth\Backend\AbstractBasic
{
    /**
     * @param string $username
     * @param string $password
     *
     * @return bool
     * @throws \Exception
     */
    protected function validateUserPass($username, $password)
    {
        $auth_flag = false;

        /** @var Session $session */
        $session = Cache::get('symfony.container')->get('session');
        $u = $session->get('user');

        /** @var CaseboxAuth $auth */
        $auth = Cache::get('symfony.container')->get('casebox_core.service_auth.authentication');

        /** @var UsersGroups $user */
        $user = $auth->isLogged();

        if (!$user instanceof UsersGroups) {
            $user = $auth->authenticate(trim($username), $password);

            if ($user instanceof UsersGroups) {
                $auth_flag = true;
                $u['TSV_checked'] = true;
            }
        } else {
            $auth_flag = true;
            $u['TSV_checked'] = true;
        }

        $session->set('user', $u);

        return $auth_flag;
    }
}
