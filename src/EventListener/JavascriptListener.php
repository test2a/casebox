<?php
namespace Casebox\CoreBundle\EventListener;

use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class JavascriptListener
 */
class JavascriptListener
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

        $scripts = $this->container->get('casebox_core.service.javascript_service')->getDefault();
        $this->container->get('casebox_core.service.javascript_service')->setScripts($scripts);
    }
}
