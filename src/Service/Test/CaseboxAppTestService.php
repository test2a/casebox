<?php

namespace Casebox\CoreBundle\Service\Test;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\System;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class CaseboxAppTestService
 */
class CaseboxAppTestService extends \PHPUnit_Framework_TestCase
{
    const CORE_NAME = 'cbtest';
    const USER_NAME = 'root';
    const USER_PASS = 'a';

    /**
     * @var \AppKernel
     */
    protected $kernel;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var Response
     */
    protected $response;

    /**
     * @var UsersGroups
     */
    protected $user;

    /**
     * @var Container
     */
    protected $container;

    /**
     * @inheritdoc
     */
    public function __construct($name = null, array $data = [], $dataName = '')
    {
        parent::__construct($name, $data, $dataName);

        // Bootstrap symfony
        $this->kernel = new \AppKernel(self::CORE_NAME, false);
        $this->request = Request::createFromGlobals();
        $this->response = $this->kernel->handle($this->request);

        $this->container = $this->kernel->getContainer();

        // Bootstrap casebox
        $system = new System();
        $system->bootstrap($this->container);
    }

    /**
     * @inheritdoc
     */
    function __destruct()
    {
        // Logout
        $this->user = $this->kernel->getContainer()->get('casebox_core.service_auth.authentication')->logout();

        // Terminate application
        $this->kernel->terminate($this->request, $this->response);
    }

    /**
     * Login
     * @return UsersGroups
     */
    public function login()
    {
        // Login
        $ls = $this->container->get('casebox_core.service_auth.authentication');
        $this->user = $ls->authenticate(self::USER_NAME, self::USER_PASS);
        $this->container->get('session')->set('auth', serialize($this->user));

        return $this->user;
    }

    /**
     * Logout
     * @return bool
     */
    public function logout()
    {
        return $this->kernel->getContainer()->get('casebox_core.service_auth.authentication')->logout();
    }
}
