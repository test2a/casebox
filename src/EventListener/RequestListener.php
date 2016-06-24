<?php
namespace Casebox\CoreBundle\EventListener;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\System;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;

/**
 * Class RequestListener
 */
class RequestListener
{
    /**
     * @var Container
     */
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
