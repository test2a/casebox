<?php

namespace Casebox\CoreBundle\Service\Vocabulary;

use Casebox\CoreBundle\Service\Cache;
use Symfony\Component\DependencyInjection\Dump\Container;

/**
 * Class LanguageVocabulary
 */
class LanguageVocabulary
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * TimezoneVocabulary constructor
     */
    public function __construct(Container $container = null)
    {
        if ($container instanceof Container) {
            $this->container = $container;
        } else {
            $this->container = Cache::get('symfony.container');
        }
    }

    /**
     * Return all terms
     * @return array
     */
    public function getTerms()
    {
        $terms = [
            "ar" => [
                "name" => "Arabic",
                "locale" => "ar_AE",
                "long_date_format" => "F j, Y",
                "short_date_format" => "d/m/Y",
                "rtl" => true,
            ],
            "en" => [
                "name" => "English",
                "locale" => "en_US",
                "long_date_format" => "F j, Y",
                "short_date_format" => "m/d/Y",
            ],
            "es" => [
                "name" => "Spanish",
                "locale" => "es_ES",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "fr" => [
                "name" => "French",
                "locale" => "fr_FR",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "hy" => [
                "name" => "Armenian",
                "locale" => "hy_AM",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "pt" => [
                "name" => "Portuguese",
                "locale" => "pt_PT",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "ro" => [
                "name" => "Română",
                "locale" => "ro_RO",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "ru" => [
                "name" => "Русский",
                "locale" => "ru_RU",
                "long_date_format" => "j F Y",
                "short_date_format" => "d.m.Y",
            ],
            "zh" => [
                "name" => "Chinese",
                "locale" => "zh_CN",
                "long_date_format" => "F j, Y",
                "short_date_format" => "d/m/Y",
            ],
        ];

        // @todo - use cache

        return $terms;
    }

    /**
     * Find by language by language code
     *
     * @param string $code
     *
     * @return array|null
     */
    public function findByLanguage($code)
    {
        $terms = $this->getTerms();

        $result = null;

        if (!empty($terms[$code])) {
            $result = $terms[$code];

            if (empty($result['time_format'])) {
                $result['time_format'] = 'H:i';
            }
        }

        return $result;
    }
}
