<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class TreeInitializeEvent
 */
class TreeInitializeEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * TreeInitializeEvent constructor
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
