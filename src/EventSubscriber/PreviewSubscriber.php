<?php

namespace Casebox\CoreBundle\EventSubscriber;

use Casebox\CoreBundle\Event\BeforeGeneratePreviewEvent;
use Casebox\CoreBundle\Event\GeneratePreviewEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Class PreviewSubscriber
 */
class PreviewSubscriber implements EventSubscriberInterface
{
    /**
     * @param BeforeGeneratePreviewEvent $event
     */
    public function onBeforeGeneratePreview(BeforeGeneratePreviewEvent $event)
    {
        // code...
    }

    /**
     * @param GeneratePreviewEvent $event
     */
    public function onGeneratePreview(GeneratePreviewEvent $event)
    {
        // code...
    }

    /**
     * @return array
     */
    static function getSubscribedEvents()
    {
        return [
            'beforeGeneratePreview' => 'onBeforeGeneratePreview',
            'generatePreview' => 'onGeneratePreview',
        ];
    }
}
