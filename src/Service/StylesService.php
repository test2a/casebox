<?php

namespace Casebox\CoreBundle\Service;

/**
 * Class StylesService
 */
class StylesService
{
    /**
     * @var \Twig_Environment
     */
    protected $twig;

    /**
     * @var array
     */
    protected $styles;

    /**
     * @return array
     */
    public function getStyles()
    {
        return $this->styles;
    }

    /**
     * @param array $styles
     *
     * @return StylesService $this
     */
    public function setStyles(array $styles)
    {
        if (empty($this->styles)) {
            $this->styles = $styles;
        } else {
            $this->styles = array_merge($this->styles, $styles);
        }

        return $this;
    }

    /**
     * @return array
     */
    public function getDefault()
    {
        $styles = [
            'ext-theme-classic-all' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/js/ext/packages/ext-theme-classic/build/resources/ext-theme-classic-all.css',
            ],
            'extjs-ace-styles' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/js/extjs-ace/styles.css',
            ],
            'min-css' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/min/css.css',
            ],
            'csstheme' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/min/csstheme.css',
            ],
            'caseboxindex' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/css/caseboxindex.css',
            ],
            'leaflet' => [
                'rel' => 'stylesheet',
                'type' => 'text/css',
                'href' => '/js/leaflet/leaflet.css',
            ],
        ];

        return $styles;
    }

    /**
     * @return string
     */
    public function getRendered()
    {
        $html = '';
        
        if (!empty($this->styles)) {
            foreach ($this->styles as $style) {
                if (empty($style['href'])) {
                    continue;
                }

                if (empty($style['rel'])) {
                    $style['rel'] = 'stylesheet';
                }
                
                if (empty($style['type'])) {
                    $style['type'] = 'text/css';
                }
                
                $html .= $this->getTwig()->render('CaseboxCoreBundle:render:style_render.html.twig', $style);
            }
        }

        return $html;
    }

    /**
     * @return \Twig_Environment
     */
    public function getTwig()
    {
        return $this->twig;
    }

    /**
     * @param \Twig_Environment $twig
     *
     * @return StylesService $this
     */
    public function setTwig(\Twig_Environment $twig)
    {
        $this->twig = $twig;

        return $this;
    }
}
