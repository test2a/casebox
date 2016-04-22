<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeSolrCommitEvent
 */
class BeforeSolrCommitEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeSolrCommitEvent constructor
     * @param \Apache_Solr_Service|null $params
     */
    public function __construct($params = null)
    {
        $this->params = $params;
    }

    /**
     * @return array
     */
    public function getParams()
    {
        return $this->params;
    }
}
