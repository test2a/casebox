<?php

namespace Casebox\CoreBundle\Event;

use Casebox\CoreBundle\Service\Objects\Object;
use Symfony\Component\EventDispatcher\Event;

/**
 * Class NodeDbUpdateEvent
 */
class NodeDbUpdateEvent extends Event
{
    /**
     * @var Object
     */
    protected $params;

    /**
     * NodeDbUpdateEvent constructor
     */
    public function __construct(Object $object)
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
