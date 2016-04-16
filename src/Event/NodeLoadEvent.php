<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class NodeLoadEvent
 */
class NodeLoadEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * NodeLoadEvent constructor
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
