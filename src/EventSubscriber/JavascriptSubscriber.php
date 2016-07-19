<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class JavascriptSubscriber
 */
class JavascriptSubscriber implements EventSubscriberInterface
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * Implements attachJavascript().
     */
    public function attachJavascript()
    {
        $scripts = $this->container->get('casebox_core.service.javascript_service')->getDefault();
        $this->container->get('casebox_core.service.javascript_service')->setScripts($scripts);
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'attachJavascript' => 'attachJavascript',
        ];
    }

    /**
     * @param Container $container
     *
     * @return JavascriptSubscriber $this
     */
    public function setContainer(Container $container)
    {
        $this->container = $container;

        return $this;
    }
}
