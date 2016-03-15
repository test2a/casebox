<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class GetAccessForObjectEvent
 */
class GetAccessForObjectEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * GetAccessForObjectEvent constructor
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
