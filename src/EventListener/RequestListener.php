<?php
namespace Casebox\CoreBundle\EventListener;

use Casebox\CoreBundle\Service\System;
use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class RequestListener
 */
class RequestListener
{
    private $container;

    /**
     * RequestListener constructor
     */
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    /**
     * @param GetResponseEvent $event
     */
    public function onKernelRequest(GetResponseEvent $event)
    {
        if (!$event->isMasterRequest()) {
            return;
        }

        // Bootstrap casebox application settings
        $system = new System();
        $system->bootstrap($this->container, $event->getRequest());
    }
}
