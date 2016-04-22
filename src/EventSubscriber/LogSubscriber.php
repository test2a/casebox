<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeLogAddEvent;
use Casebox\CoreBundle\Event\LogAddEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class LogSubscriber
 */
class LogSubscriber implements EventSubscriberInterface
{

    public function onBeforeLogAdd(BeforeLogAddEvent $event)
    {
        // code...
    }

    public function onLogAdd(LogAddEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'beforelogadd' => 'onBeforeLogAdd',
            'logadd' => 'onLogAdd',
        ];
    }
}
