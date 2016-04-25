<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeNodeDbCreateEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbDeleteEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbRestoreEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbUpdateEvent;
use Casebox\CoreBundle\Event\NodeDbCreateEvent;
use Casebox\CoreBundle\Event\NodeDbCreateOrUpdateEvent;
use Casebox\CoreBundle\Event\NodeDbDeleteEvent;
use Casebox\CoreBundle\Event\NodeDbRestoreEvent;
use Casebox\CoreBundle\Event\NodeDbUpdateEvent;
use Casebox\CoreBundle\Event\NodeLoadEvent;
use Casebox\CoreBundle\Event\NodeObjectsLoadEvent;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class ObjectSubscriber
 */
class ObjectSubscriber implements EventSubscriberInterface
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * @param BeforeNodeDbCreateEvent $event
     */
    public function onBeforeNodeDbCreate(BeforeNodeDbCreateEvent $event)
    {
        // code...
    }

    /**
     * @param NodeDbCreateEvent $event
     */
    public function onNodeDbCreate(NodeDbCreateEvent $event)
    {
        // Dispatch system folders plugin
        $this
            ->container
            ->get('casebox_core.service_plugins.system_folders')
            ->onNodeDbCreate($event->getObject());
    }

    /**
     * @param NodeDbCreateOrUpdateEvent $event
     */
    public function onBeforeNodeDbCreateOrUpdate(NodeDbCreateOrUpdateEvent $event)
    {
        // Dispatch auto set fields plugin
        $this
            ->container
            ->get('casebox_core.service_plugins.auto_set_fields')
            ->onBeforeNodeDbCreateOrUpdate($event->getObject());
    }

    /**
     * @param BeforeNodeDbUpdateEvent $event
     */
    public function onBeforeNodeDbUpdate(BeforeNodeDbUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param NodeDbUpdateEvent $event
     */
    public function onNodeDbUpdate(NodeDbUpdateEvent $event)
    {
        // code...
    }

    /**
     * @param BeforeNodeDbDeleteEvent $event
     */
    public function onBeforeNodeDbDelete(BeforeNodeDbDeleteEvent $event)
    {
        // code...
    }

    /**
     * @param NodeDbDeleteEvent $event
     */
    public function onNodeDbDelete(NodeDbDeleteEvent $event)
    {
        // code...
    }

    /**
     * @param BeforeNodeDbRestoreEvent $event
     */
    public function onBeforeNodeDbRestore(BeforeNodeDbRestoreEvent $event)
    {
        // code...
    }

    /**
     * @param NodeDbRestoreEvent $event
     */
    public function onNodeDbRestore(NodeDbRestoreEvent $event)
    {
        // code...
    }

    /**
     * @param NodeObjectsLoadEvent $event
     */
    public function onObjectsLoad(NodeObjectsLoadEvent $event)
    {
        // code...
    }

    /**
     * @param NodeLoadEvent $event
     */
    public function onNodeLoad(NodeLoadEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    public static function getSubscribedEvents()
    {
        return [
            'beforeNodeDbCreate' => 'onBeforeNodeDbCreate',
            'beforeNodeDbCreateOrUpdate' => 'onBeforeNodeDbCreateOrUpdate',
            'nodeDbCreate' => 'onNodeDbCreate',
            'beforeNodeDbUpdate' => 'onBeforeNodeDbUpdate',
            'nodeDbUpdate' => 'onNodeDbUpdate',
            'beforeNodeDbDelete' => 'onBeforeNodeDbDelete',
            'nodeDbDelete' => 'onNodeDbDelete',
            'beforeNodeDbRestore' => 'onBeforeNodeDbRestore',
            'nodeDbRestore' => 'onNodeDbRestore',
            'onObjectsLoad' => 'onObjectsLoad',
            'onNodeLoad' => 'onNodeLoad',
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
     * @return ObjectSubscriber $this
     */
    public function setContainer(Container $container)
    {
        $this->container = $container;

        return $this;
    }
}
