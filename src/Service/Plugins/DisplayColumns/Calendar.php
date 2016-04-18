<?php

namespace Casebox\CoreBundle\Service\Plugins\DisplayColumns;

use Casebox\CoreBundle\Service\Util;

/**
 * Class Calendar
 */
class Calendar extends Base
{
    protected $fromParam = 'calendar';

    public function onBeforeSolrQuery(&$p)
    {
        $p['rows'] = 500;
    }

    public function onSolrQuery(&$p)
    {
        $result = &$p['result'];
        $data = &$result['data'];
        $ip = &$p['inputParams'];
        $view = &$ip['view'];
        $facets = &$ip['facets'];

        $coloring = empty($view['coloring']) ? [] : Util\toTrimmedArray($view['coloring']);

        $view['coloring'] = $coloring;

        // detect active coloring facet
        $coloringField = $this->getActiveColoringField($p);
        $activeFacetClass = null;

        $types = [];
        foreach ($coloring as $facetAlias) {
            if (!empty($facets[$facetAlias]->field)) {
                $types[] = $facets[$facetAlias]->field;

                if ($coloringField == $facets[$facetAlias]->field) {
                    $activeFacetClass = &$facets[$facetAlias];
                }
            }
        }

        $result['view']['coloring'] = $types;

        $coloringItems = [];
        if (!empty($activeFacetClass)) {
            $cf = $activeFacetClass->getClientData(['colors' => true]);

            $result['facets'][$activeFacetClass->field] = $cf;
            $coloringItems = $cf['items'];
        }

        $rez = [];
        foreach ($data as $r) {
            $fv = empty($r[$coloringField]) ? [] : Util\toNumericArray($r[$coloringField]);

            if (empty($fv)) {
                $r['cls'] = 'user-color-'.$r['cid'];
                $rez[] = $r;
            } else {
                foreach ($fv as $v) {
                    if (!empty($coloringItems[$v])) {
                        $c = $coloringItems[$v];
                        if (!empty($c['cls'])) {
                            $r['cls'] = $c['cls'];
                        }
                        if (!empty($c['color'])) {
                            $r['style'] = 'background-color: '.$c['color'];
                        }
                    }
                    $rez[] = $r;
                }
            }
        }

        $result['data'] = $rez;
    }

    /**
     * Detect active coloring facet
     *
     * @param array $p
     *
     * @return string|null
     */
    protected function getActiveColoringField($p)
    {
        $ip = &$p['inputParams'];
        $view = &$ip['view'];
        $facets = &$ip['facets'];

        $rez = null;

        if (!empty($ip['selectedColoring'])) {
            $rez = $ip['selectedColoring'];
        } else {
            if (!empty($view['defaultColoring'])) {
                $rez = $view['defaultColoring'];
            } elseif (!empty($view['defaultColoring'])) {
                $rez = $view['coloring'][0];
            }

            if (!empty($facets[$rez])) {
                $rez = $facets[$rez]->field;
            }
        }

        return $rez;
    }

    public function getSolrFields($nodeId = false, $templateId = false)
    {
        $rez = parent::getSolrFields($nodeId, $templateId);

        // Add coloring field to request field list
        $coloringField = $this->getActiveColoringField($this->params);

        if (!in_array($coloringField, $rez['fields'])) {
            $rez['fields'][] = $coloringField;
        }

        return $rez;
    }
}
