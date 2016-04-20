<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class NodeObjectsLoadEvent
 */
class NodeObjectsLoadEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * NodeLoadEvent constructor
     * @param array $params
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
