<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeSolrUpdateEvent
 */
class BeforeSolrUpdateEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeSolrUpdateEvent constructor
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
