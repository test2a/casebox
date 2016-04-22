<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class SolrUpdateEvent
 */
class SolrUpdateEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * SolrUpdateEvent constructor
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
