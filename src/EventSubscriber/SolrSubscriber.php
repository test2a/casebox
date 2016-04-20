<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeNodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\BeforeSolrCommitEvent;
use Casebox\CoreBundle\Event\BeforeSolrQueryEvent;
use Casebox\CoreBundle\Event\BeforeSolrUpdateEvent;
use Casebox\CoreBundle\Event\NodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\SolrCommitEvent;
use Casebox\CoreBundle\Event\SolrQueryEvent;
use Casebox\CoreBundle\Event\SolrQueryWarmUpEvent;
use Casebox\CoreBundle\Event\SolrUpdateEvent;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Solr\Client;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class SolrSubscriber
 */
class SolrSubscriber implements EventSubscriberInterface
{
    /**
     * @param SolrQueryWarmUpEvent $event
     */
    public function onSolrQueryWarmUp(SolrQueryWarmUpEvent $event)
    {
        $params = $event->getParams();

        $this
            ->container
            ->get('casebox_core.service_plugins_display_columns.display_columns')
            ->onSolrQueryWarmUp($params);
    }

    /**
     * @param BeforeSolrQueryEvent $event
     */
    public function onBeforeSolrQuery(BeforeSolrQueryEvent $event)
    {
        $params = $event->getParams();

        $this
            ->container
            ->get('casebox_core.service_plugins_display_columns.display_columns')
            ->onBeforeSolrQuery($params);
    }
    
    /**
     * @param SolrQueryEvent $event
     */
    public function onSolrQuery(SolrQueryEvent $event)
    {
        $params = $event->getParams();

        $this
            ->container
            ->get('casebox_core.service_plugins_display_columns.display_columns')
            ->onSolrQuery($params);
    }
    
    /**
     * @var Container
     */
    protected $container;
    
    /**
     * Update tree action
     */
    public function onTreeUpdate()
    {
        if (Config::getFlag('disableSolrIndexing')) {
            return;
        }

        $solrClient = new Client();
        $solrClient->updateTree();

        unset($solrClient);
    }

    /**
     * @param BeforeSolrUpdateEvent $event
     */
    public function onBeforeSolrUpdate(BeforeSolrUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param SolrUpdateEvent $event
     */
    public function onSolrUpdate(SolrUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param BeforeNodeSolrUpdateEvent $event
     */
    public function onBeforeNodeSolrUpdate(BeforeNodeSolrUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param NodeSolrUpdateEvent $event
     */
    public function onNodeSolrUpdate(NodeSolrUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param BeforeSolrCommitEvent $event
     */
    public function onBeforeSolrCommit(BeforeSolrCommitEvent $event)
    {
        // code...
    }

    /**
     * @param SolrCommitEvent $event
     */
    public function onSolrCommit(SolrCommitEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'onSolrQueryWarmUp' => 'onSolrQueryWarmUp',
            'onBeforeSolrQuery' => 'onBeforeSolrQuery',
            'onSolrQuery' => 'onSolrQuery',
            'onSolrTreeUpdate' => 'onTreeUpdate',
            'onBeforeSolrUpdate' => 'onBeforeSolrUpdate',
            'onSolrUpdate' => 'onSolrUpdate',
            'beforeNodeSolrUpdate' => 'onBeforeNodeSolrUpdate',
            'nodeSolrUpdate' => 'onNodeSolrUpdate',
            'onBeforeSolrCommit' => 'onBeforeSolrCommit',
            'onSolrCommit' => 'onSolrCommit',
        ];
    }

    /**
     * @return Container
     */
    public function getContainer()
    {
        return $this->container;
    }

    /**
     * @param Container $container
     *
     * @return SolrSubscriber $this
     */
    public function setContainer(Container $container)
    {
        $this->container = $container;

        return $this;
    }
}
