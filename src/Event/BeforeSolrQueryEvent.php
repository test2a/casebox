<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeSolrQueryEvent
 */
class BeforeSolrQueryEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeSolrQueryEvent constructor
     */
    public function __construct(array $params)
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
