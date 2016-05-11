<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Service\JavascriptService;
use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;

/**
 * Class JavascriptServiceTest
 */
class JavascriptServiceTest extends CaseboxAppTestService
{
    /**
     * @var JavascriptService
     */
    protected $jss;

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->jss = $this->container->get('casebox_core.service.javascript_service');
    }

    /**
     * Test getDefault() method.
     */
    public function testGetDefault()
    {
        $array = $this->jss->getDefault();
        $this->assertNotEmpty($array);
        $this->assertArrayHasKey('header', $array);
        $this->assertArrayHasKey('footer', $array);
    }

    /**
     * Test setScripts() method.
     */
    public function testSetScripts()
    {
        $params = [
            'header' => [
                'foo' => [
                    'src' => 'foo.js',
                ],
            ],
            'footer' => [
                'bar' => [
                    'src' => 'bar.js',
                ],
            ],
        ];

        $this->jss->setScripts($params);

        $array = $this->jss->getScripts();
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('header', $array);
        $this->assertArrayHasKey('footer', $array);

        $this->assertArrayHasKey('foo', $array['header']);
        $this->assertArrayHasKey('bar', $array['footer']);

        $this->assertArrayHasKey('foo', $array['header']);
        $this->assertArrayHasKey('bar', $array['footer']);;
    }

    /**
     * Test getScripts() method.
     */
    public function testGetScripts()
    {
        $array = $this->jss->getScripts();
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('header', $array);
        $this->assertArrayHasKey('footer', $array);

        $this->assertArrayHasKey('progress', $array['header']);
    }

    /**
     * Test getRendered() method.
     */
    public function testGetRendered()
    {
        $array = $this->jss->getRendered($this->jss->getScripts());
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('header', $array);
        $this->assertArrayHasKey('footer', $array);

        $this->assertNotEmpty($array['header']);
        $this->assertNotEmpty($array['footer']);
    }
}
