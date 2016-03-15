<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class BeforeGeneratePreviewEvent
 */
class BeforeGeneratePreviewEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * BeforeGeneratePreviewEvent constructor
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
