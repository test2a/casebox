<?php
namespace Casebox\CoreBundle\Traits;

use Casebox\CoreBundle\Service\Cache;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\Translation\Translator;

/**
 * Class TranslatorTrait
 */
trait TranslatorTrait
{
    /**
     * Translate a given param.
     *
     * @param string $name
     * @param string|null $lang
     *
     * @return string
     */
    public function trans($name, $lang = null)
    {
        /** @var Translator $translator */
        $translator = Cache::get('symfony.container')->get('translator');
        $translated = $translator->trans($name);

        return $translated;
    }
}
