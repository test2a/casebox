<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeNodeSolrUpdateEvent
 */
class BeforeNodeSolrUpdateEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeNodeSolrUpdateEvent constructor
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
