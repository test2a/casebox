<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class StylesSubscriber
 */
class StylesSubscriber implements EventSubscriberInterface
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * Implements attachStyles().
     */
    public function attachStyles()
    {
        $styles = $this->container->get('casebox_core.service.styles_service')->getDefault();
        $this->container->get('casebox_core.service.styles_service')->setStyles($styles);
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'attachStyles' => 'attachStyles',
        ];
    }

    /**
     * @param Container $container
     *
     * @return StylesSubscriber $this
     */
    public function setContainer(Container $container)
    {
        $this->container = $container;

        return $this;
    }
}
