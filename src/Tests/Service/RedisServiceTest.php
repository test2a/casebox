<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Service\RedisService;
use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;

class RedisServiceTest extends CaseboxAppTestService
{
    /**
     * @var RedisService
     */
    protected $redisService;

    /**
     * NotificationsTest constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->redisService = $this->container->get('casebox_core.service.redis_service');
    }

    /**
     * Test set() method.
     */
    public function testSet()
    {
        $this->redisService->set('foo', 'foo');
        $result = $this->redisService->get('foo');
        $this->assertNotEmpty($result);
        $this->assertEquals('foo', $result);
    }

    /**
     * Test get() method.
     */
    public function testGet()
    {
        $this->redisService->set('foo', 'foo');
        $result = $this->redisService->get('foo');
        $this->assertNotEmpty($result);
        $this->assertEquals('foo', $result);
    }

    /**
     * Test finKey() method.
     */
    public function testFinKey()
    {
        $this->redisService->set('foo', 'foo');
        $result = $this->redisService->finKey('foo');

        $this->assertNotEmpty($result);
        $this->assertEquals('foo', $result[0]);
    }

    /**
     * Test del() method.
     */
    public function testDel()
    {
        $this->redisService->set('foo', 'foo');
        $result = $this->redisService->get('foo');
        $this->assertNotEmpty($result);
        $this->assertEquals('foo', $result);

        $this->redisService->del(['foo']);
        $result = $this->redisService->get('foo');
        $this->assertEmpty($result);
    }
}
