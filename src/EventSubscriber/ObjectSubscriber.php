<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeNodeDbCreateEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbDeleteEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbRestoreEvent;
use Casebox\CoreBundle\Event\BeforeNodeDbUpdateEvent;
use Casebox\CoreBundle\Event\NodeDbCreateEvent;
use Casebox\CoreBundle\Event\NodeDbDeleteEvent;
use Casebox\CoreBundle\Event\NodeDbRestoreEvent;
use Casebox\CoreBundle\Event\NodeDbUpdateEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class ObjectSubscriber
 */
class ObjectSubscriber implements EventSubscriberInterface
{
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
        // code...
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
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'beforeNodeDbCreate' => 'onBeforeNodeDbCreate',
            'nodeDbCreate' => 'onNodeDbCreate',
            'beforeNodeDbUpdate' => 'onBeforeNodeDbUpdate',
            'nodeDbUpdate' => 'onNodeDbUpdate',
            'beforeNodeDbDelete' => 'onBeforeNodeDbDelete',
            'nodeDbDelete' => 'onNodeDbDelete',
            'beforeNodeDbRestore' => 'onBeforeNodeDbRestore',
            'nodeDbRestore' => 'onNodeDbRestore',
        ];
    }
}
