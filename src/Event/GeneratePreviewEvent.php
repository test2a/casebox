<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class GeneratePreviewEvent
 */
class GeneratePreviewEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * GeneratePreviewEvent constructor
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
