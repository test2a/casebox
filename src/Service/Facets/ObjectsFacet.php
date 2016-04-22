<?php

namespace Casebox\CoreBundle\Service\Facets;

use Casebox\CoreBundle\Service\TreeNode;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Objects;

/**
 * Class ObjectsFacet
 */
class ObjectsFacet extends StringsFacet
{
    /**
     * @param array $options
     *
     * @return array
     */
    public function getClientData($options = array())
    {
        $rez = array(
            'f' => $this->field,
            'title' => $this->getTitle(),
            'items' => array()
        );

        $this->colors = $colors = empty($options['colors']) ? array() : $this->getColors();

        $dbnode = new TreeNode\Dbnode();

        foreach ($this->solrData as $k => $v) {
            $rez['items'][$k] = array(
                'name' => $dbnode->getName($k)
                ,'count' => $v
            );

            if (!empty($colors[$k])) {
                $rez['items'][$k]['color'] = $colors[$k];
            }
        }

        // Check if have default sorting set in cofig
        if (!empty($this->config['sort'])) {
            $sp = $this->getSortParams();

            Util\sortRecordsArray(
                $rez['items'],
                $sp['property'],
                $sp['direction'],
                $sp['type'],
                true
            );

            // Add sort param for client side
            $rez['sort'] = $sp;
        }

        return $rez;
    }

    protected function getColors()
    {
        $rez = array();
        $ids = array_keys((array) $this->solrData);

        $objects = Objects::getCachedObjects($ids);

        foreach ($objects as $o) {
            $d = $o->getData();
            if (!empty($d['data']['color'])) {
                $rez[$d['id']] = $d['data']['color'];
            }
        }

        return $rez;
    }
}
