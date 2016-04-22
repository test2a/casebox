<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class LogAddEvent
 */
class LogAddEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * LogAddEvent constructor
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
