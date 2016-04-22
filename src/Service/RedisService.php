<?php

namespace Casebox\CoreBundle\Service;

use Predis\Client;
use Symfony\Component\DependencyInjection\Container;

/**
 * Class RedisService
 */
class RedisService
{
    /**
     * @var Container
     */
    protected $container;

    /**
     * RedisService constructor
     */
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    /**
     * @param string $key Cache key
     * @param string $value Cache value
     * @param int|null $ttl Cache timeout in seconds
     *
     * @see http://redis.io/commands/set
     *
     * @return mixed
     */
    public function set($key, $value, $ttl = null)
    {
        if (!empty($ttl) && $ttl > 0) {
            return $this->getRedisClient()->set($key, $value, 'EX', $ttl);
        } else {
            return $this->getRedisClient()->set($key, $value);
        }
    }

    /**
     * @param string $key
     *
     * @return string
     */
    public function get($key)
    {
        return $this->getRedisClient()->get($key);
    }

    /**
     * @param string $key
     *
     * @return array
     */
    public function finKey($key)
    {
        $result = $this->getRedisClient()->scan(0, ['MATCH' => $key]);

        return (!empty($result[1])) ? $result[1] : null;
    }

    /**
     * @param array $keys
     *
     * @return int
     */
    public function del(array $keys)
    {
        return $this->getRedisClient()->del($keys);
    }

    /**
     * @return mixed
     */
    public function flushAll()
    {
        return $this->getRedisClient()->flushall();
    }

    /**
     * @return Client
     */
    public function getRedisClient()
    {
        $host = $this->container->getParameter('redis_host');
        $port = $this->container->getParameter('redis_port');

        $config = [
            'scheme' => 'tcp',
            'host' => (!empty($host)) ? $host : '127.0.0.1',
            'port' => (!empty($port)) ? $port : 6379,
        ];

        return new Client($config);
    }
}
