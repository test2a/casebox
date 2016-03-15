<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeNodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\BeforeSolrCommitEvent;
use Casebox\CoreBundle\Event\BeforeSolrUpdateEvent;
use Casebox\CoreBundle\Event\NodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\SolrCommitEvent;
use Casebox\CoreBundle\Event\SolrUpdateEvent;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Solr\Client;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class SolrSubscriber
 */
class SolrSubscriber implements EventSubscriberInterface
{
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
            'casebox.solr.ontreeupdate' => 'onTreeUpdate',
            'onBeforeSolrUpdate' => 'onBeforeSolrUpdate',
            'onSolrUpdate' => 'onSolrUpdate',
            'beforeNodeSolrUpdate' => 'onBeforeNodeSolrUpdate',
            'nodeSolrUpdate' => 'onNodeSolrUpdate',
            'onBeforeSolrCommit' => 'onBeforeSolrCommit',
            'onSolrCommit' => 'onSolrCommit',
        ];
    }
}
