<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class SolrQueryWarmUpEvent
 */
class SolrQueryWarmUpEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * SolrQueryWarmUpEvent constructor
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
