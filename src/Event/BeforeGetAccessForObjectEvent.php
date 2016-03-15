<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeGetAccessForObjectEvent
 */
class BeforeGetAccessForObjectEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeGetAccessForObjectEvent constructor
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
