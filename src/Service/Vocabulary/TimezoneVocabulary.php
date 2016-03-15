<?php

namespace Casebox\CoreBundle\Service\Vocabulary;

use Casebox\CoreBundle\Service\Cache;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class TimezoneVocabulary
 */
class TimezoneVocabulary implements VocabularyInterface
{
    const CACHE_KEY = 'timezone';

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
     * Load and return all terms
     * @return array
     */
    public function getTerms()
    {
        $redis = $this->container->get('casebox_core.service.redis_service');

        if (empty($redis->get(self::CACHE_KEY))) {
            $file = __DIR__.'/mockup/timezone.json'; // @todo - use config param for this
            $terms = json_decode(file_get_contents($file), true);

            $redis->set(self::CACHE_KEY, serialize($terms), 60 * 24);
        } else {
            $terms = unserialize($redis->get(self::CACHE_KEY));
        }

        return $terms;
    }
}
