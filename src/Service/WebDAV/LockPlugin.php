<?php
namespace Casebox\CoreBundle\Service\WebDAV;

use Casebox\CoreBundle\Service\User;
use Sabre\DAV\Locks\LockInfo;
use \Sabre\DAV\Server;
use Casebox\CoreBundle\Service\Cache;
use Sabre\DAV\ServerPlugin;

class LockPlugin extends ServerPlugin
{
    protected $server;

    public function getName()
    {
        return 'cblock';
    }

    public function initialize(Server $server)
    {
        $this->server = $server;
        $server->on('beforeLock', [$this, 'beforeLock']);
    }

    public function beforeLock($path, LockInfo $lock)
    {
        $user = Cache::get('symfony.container')->get('casebox_core.service.user')->getUserData();
        $lock->owner = User::getDisplayName($user['id']);
        return true;
    }
}
