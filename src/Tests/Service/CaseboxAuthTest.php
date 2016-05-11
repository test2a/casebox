<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\Auth\CaseboxAuth;
use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;
use Symfony\Component\HttpFoundation\Session\Session;

class CaseboxAuthTest extends CaseboxAppTestService
{
    /**
     * @var CaseboxAuth
     */
    protected $auth;

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->auth = $this->container->get('casebox_core.service_auth.authentication');

        $this->login();
    }

    /**
     * Test isLogged() method.
     */
    public function testIsLogged()
    {
        /** @var UsersGroups $result */
        $result = $this->auth->isLogged();
        $this->assertNotEmpty($result);

        $this->assertNotEmpty('id', $result->getId());
        $this->assertEquals(1, $result->getId());
    }

    /**
     * Test getSessionData() method.
     */
    public function testGetSessionData()
    {
        $result = $this->auth->getSessionData(1);
        $this->assertNotEmpty($result);

        $this->assertArrayHasKey('id', $result);
        $this->assertEquals(1, $result['id']);
        $this->assertEquals('root', $result['name']);
    }

    /**
     * Test generateSalt() method.
     */
    public function testGenerateSalt()
    {
        $result = $this->auth->generateSalt();
        $this->assertNotEmpty($result);

        $this->assertNotEmpty($result);
    }
}
