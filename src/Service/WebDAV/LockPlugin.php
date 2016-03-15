<?php
namespace Casebox\CoreBundle\Service\WebDAV;

use \Sabre\DAV\Server;
use Casebox\CoreBundle\Service\Cache;

class LockPlugin extends \Sabre\DAV\ServerPlugin
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

    public function beforeLock($path, \Sabre\DAV\Locks\LockInfo $lock)
    {
        $path = $path; //dummy codacy assignment
        $lock->owner = \Casebox\CoreBundle\Service\User::getDisplayName(Cache::get('session')->get('user')['id']);
        // error_log('beforeLock: ' . $lock->owner);
        return true;
    }
}
