<?php

namespace Casebox\CoreBundle\Service;

use Symfony\Component\DependencyInjection\Container;

/**
 * Class Cache
 */
class Cache extends Singleton
{
    /**
     * Check if a name is defined in cache
     *
     * @param  string $name
     *
     * @return boolean
     */
    public static function exist($name)
    {
        return isset(static::getInstance()->{$name});
    }

    /**
     * Set a variable value into the cache
     *
     * @param string $name name of variable
     * @param  $value
     */
    public static function set($name, $value)
    {
        static::getInstance()->{$name} = $value;
    }

    /**
     * Unset or remove a variable from the cache
     *
     * @param string $name name of variable
     */
    public static function remove($name)
    {
        unset(static::getInstance()->{$name});
    }

    /**
     * Get a variable value From the cache
     *
     * @param string $name Name of variable
     * @param array $defaultValue
     *
     * @return array|string|null|\PDO|Container
     */
    public static function get($name, $defaultValue = null)
    {
        if (static::exist($name)) {
            return static::getInstance()->{$name};
        }

        return $defaultValue;
    }

    public static function getAll()
    {
        return static::getInstance();
    }
}
