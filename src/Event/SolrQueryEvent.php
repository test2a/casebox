<?php

namespace Casebox\CoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;

/**
 * Class SolrQueryEvent
 */
class SolrQueryEvent extends Event
{
    /**
     * @var array
     */
    protected $params;

    /**
     * SolrQueryEvent constructor
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
