<?php
namespace Casebox\CoreBundle\Service\WebDAV;

use Sabre\DAV\Server;
use Sabre\DAV\ServerPlugin;

class CustomPropertiesPlugin extends ServerPlugin
{
    public function getFeatures()
    {
        return array();
    }

    public function getHTTPMethods($uri)
    {
    }

    public function initialize(Server $server)
    {
        $this->server = $server;
        $server->subscribeEvent('beforeGetProperties', array($this, 'beforeGetProperties'));
        $server->subscribeEvent('afterGetProperties', array($this, 'afterGetProperties'));
    }

    public function beforeGetProperties($path, $node, &$requestedProperties, &$returnedProperties)
    {
        if (!in_array('{DAV:}creationdate', $requestedProperties)) {
            if (method_exists($node, 'getCreationDate')) {
                $returnedProperties[200]['{DAV:}creationdate'] = new CreationDate($node->getCreationDate());
            }

        }
    }

    public function afterGetProperties($path, $properties, $node)
    {
    }
}
