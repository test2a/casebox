<?php

namespace Casebox\CoreBundle\Service\Templates;

use Casebox\CoreBundle\Service\Singleton;

/**
 * Class SingletonCollection
 *
 * Templates singleton collection class
 */
class SingletonCollection extends Collection
{
    /**
     * @var null|Singleton
     */
    protected static $_instance = null;

    /**
     * Prevent direct object creation
     */
    final private function __construct()
    {
    }

    /**
     * Prevent object cloning
     */
    final private function __clone()
    {
    }

    /**
     * Returns new or existing Singleton instance
     * @return Singleton
     */
    final public static function getInstance()
    {
        if (null !== static::$_instance) {
            return static::$_instance;
        }

        static::$_instance = new static();

        return static::$_instance;
    }
}
