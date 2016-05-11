<?php

namespace Casebox\CoreBundle\Tests;

use Casebox\CoreBundle\Service\StylesService;
use Casebox\CoreBundle\Service\Test\CaseboxAppTestService;

/**
 * Class StylesServiceTest
 */
class StylesServiceTest extends CaseboxAppTestService
{
    /**
     * @var StylesService
     */
    protected $ss;

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->ss = $this->container->get('casebox_core.service.styles_service');
    }

    /**
     * Test getDefault() method.
     */
    public function testGetDefault()
    {
        $array = $this->ss->getDefault();
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('min-css', $array);
        $this->assertArrayHasKey('csstheme', $array);
        $this->assertArrayHasKey('caseboxindex', $array);
    }

    /**
     * Test setScripts() method.
     */
    public function testSetStyles()
    {
        $styles = [
            'foo' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => 'foo.css',
            ],
        ];
        $this->ss->setStyles($styles);

        $array = $this->ss->getStyles();
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('foo', $array);
    }

    /**
     * Test getStyles() method.
     */
    public function testGetStyles()
    {
        $array = $this->ss->getStyles();
        $this->assertNotEmpty($array);

        $this->assertArrayHasKey('min-css', $array);
        $this->assertArrayHasKey('csstheme', $array);
        $this->assertArrayHasKey('caseboxindex', $array);
    }
}
