<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;

/**
 * Class BrowserTreeTest
 */
class BrowserTreeTest extends CaseboxAppTestService
{
    /**
     * @inheritdoc
     */
    public function __construct()
    {
        parent::__construct();

        $this->login();
    }

    /**
     * Test getChildren() method.
     */
    public function testGetChildren()
    {
        $params = \GuzzleHttp\json_decode(
            '{"from":"tree","path":"/1","node":"root"}',
            true
        );

        $array = $this->kernel->getContainer()->get('casebox_core.service.browser_tree')->getChildren($params);

        // Check if 3 tree items arrived
        $this->assertEquals(3, count($array));
    }
}
