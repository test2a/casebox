<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\GetTimeCostEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class TimeTrackingSubscriber
 */
class TimeTrackingSubscriber implements EventSubscriberInterface
{
    /**
     * @param GetTimeCostEvent $event
     */
    public function onGetTimeCost(GetTimeCostEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'onGetTimeCost' => 'onGetTimeCost',
        ];
    }
}
