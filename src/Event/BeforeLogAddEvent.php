<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeLogAddEvent
 */
class BeforeLogAddEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeLogAddEvent constructor
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
