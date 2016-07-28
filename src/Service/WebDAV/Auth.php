<?php
namespace Casebox\CoreBundle\Service\WebDAV;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\Cache;
use Sabre\DAV\Auth\Backend\AbstractBasic;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class Auth
 */
class Auth extends AbstractBasic
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * @param string $username
     * @param string $password
     *
     * @return bool
     * @throws \Exception
     */
    protected function validateUserPass($username, $password)
    {
        $this->container = Cache::get('symfony.container');
        $user = $this->container->get('session')->get('user');

        if ($user['id']) {
            return true;
        }

        return false;
    }
}
