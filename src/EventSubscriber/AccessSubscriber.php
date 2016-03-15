<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeGetAccessForObjectEvent;
use Casebox\CoreBundle\Event\GetAccessForObjectEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class AccessSubscriber
 */
class AccessSubscriber implements EventSubscriberInterface
{

    public function onBeforeGetAccessForObject(BeforeGetAccessForObjectEvent $event)
    {
        // code...
    }

    public function onGetAccessForObject(GetAccessForObjectEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'beforeGetAccessForObject' => 'onBeforeGetAccessForObject',
            'getAccessForObject' => 'onGetAccessForObject',
        ];
    }
}
