<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\TreeInitializeEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class TreeInitializeSubscriber
 */
class TreeInitializeSubscriber implements EventSubscriberInterface
{
    /**
     * Update tree action
     */
    public function onTreeInitialize(TreeInitializeEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return ['treeInitialize' => 'onTreeInitialize'];
    }
}
