<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class NodeSolrUpdateEvent
 */
class NodeSolrUpdateEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * NodeSolrUpdateEvent constructor
     * @param \Apache_Solr_Document $object
     */
    public function __construct(\Apache_Solr_Document $object)
    {
        $this->params = $object;
    }

    /**
     * @return array
     */
    public function getParams()
    {
        return $this->params;
    }
}
