<?php

namespace Casebox\CoreBundle\Service;

use Sabre\CardDAV\Plugin;
use Sabre\DAV\Locks\Backend\File;
use Sabre\DAV\Server;
use Sabre\DAV\TemporaryFileFilterPlugin;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class WebDavService
 */
class WebDavService
{
    /**
     * server urls 'https://casebox.org/dav/{core}/edit-{id}/'
     */
    const URIPREFIX = 'dav';

    /**
     * @var Container
     */
    protected $container;

    /**
     * @param array $params
     *
     * @return mixed
     */
    public function serve(array $params)
    {
        // Make sure there is a directory in your current directory named 'public'.
        // We will be exposing that directory to WebDAV
        $p = [
            'nodeId' => 1,
            'parentDir' => null,
        ];

        // The root folder = parentNode fo the file, if mode == 'edit'
        if ($params['mode'] == 'edit') {
            $p['nodeId'] = WebDAV\Utils::getParentNodeId($params['nodeId']);
        }

        $rootNode = new WebDAV\Directory($params['rootFolder'], $p, $params);

        // The rootNode needs to be passed to the server object.
        $server = new Server($rootNode);

        // If you want to run the SabreDAV server in a custom location (using mod_rewrite for instance)
        // You can override the baseUri here.
        $baseUri = '/'.self::URIPREFIX.'/'.$params['core'];

        // For EDIT mode, the root will start directly on /dav/{core}/edit-{nodeId}/
        if ($params['mode'] == 'edit') {
            $baseUri .= '/'.$params['editFolder'];
        }

        $server->setBaseUri($baseUri);

        // Authentication
        $authBackend = new WebDAV\Auth();
        $authPlugin = new Plugin($authBackend, 'SabreDAV');

        $server->addPlugin($authPlugin);

        // Where to store temp files: LOCK files and files created by TemporaryFileFilterPlugin
        $tmpDir = Cache::get('symfony.container')->get('casebox_core.service.config')->get('upload_temp_dir').'/';
        $lockFile = $tmpDir.'locks';

        // If there is no locking file for this core, create one
        if (!is_file($lockFile)) {
            file_put_contents($lockFile, '');
        }

        // This plugin filters temp files
        $tffp = new TemporaryFileFilterPlugin($tmpDir);
        $server->addPlugin($tffp);

        // LibreOffice will NOT remove LOCK after closing the file
        // in EDIT mode disable locking, so everyone can save the file
        // if ($_SERVER['HTTP_USER_AGENT'] != 'LibreOffice') {   // WORD requires locking. and ($params['mode'] != 'edit')
        $lockBackend = new File($lockFile);
        $lockPlugin = new Plugin($lockBackend);

        // http://sabre.io/dav/clients/msoffice/
        // certain versions of Office break if the {DAV:}lockdiscovery property
        // but Word 2013 doesn't like this setting, on save it shows:
        // "Showing a dialog: files was changed by another author, combine results?"
        //
        // \Sabre\DAV\Property\LockDiscovery::$hideLockRoot = true;

        $server->addPlugin($lockPlugin);
        //}

        // Adding 'creationdate' property
        $storageBackend = new WebDAV\PropertyStorageBackend();
        $propertyStorage = new \Sabre\DAV\PropertyStorage\Plugin($storageBackend);
        $server->addPlugin($propertyStorage);

        $cbLockPlugin = new WebDAV\LockPlugin();
        $server->addPlugin($cbLockPlugin);

        // And off we go!
        $server->exec();

        return ['success' => true];
    }

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
     * @return WebDavService $this
     */
    public function setContainer($container)
    {
        $this->container = $container;

        return $this;
    }
}
