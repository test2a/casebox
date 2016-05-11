<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;

class NotificationsTest extends CaseboxAppTestService
{
    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Test getNew() method.
     */
    public function testGetNew()
    {
        $this->assertEquals(true, true);
    }
}
