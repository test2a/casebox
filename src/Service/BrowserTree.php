<?php

namespace Casebox\CoreBundle\Service;

use Casebox\CoreBundle\Service\DataModel as DM;

/**
 * Class BrowserTree
 */
class BrowserTree extends Browser
{
    /**
     * @param array $p
     *
     * @return mixed
     */
    public function getChildren($p)
    {
        $p['from'] = 'tree';

        $res = parent::getChildren($p);

        // Collect resulting record ids and get their children
        $ids = [];
        foreach ($res['data'] as &$d) {
            $ids[] = $d['nid'];
        }

        $children = DM\Tree::getChildCount($ids);

        foreach ($res['data'] as &$d) {
            if (!isset($d['loaded'])) {
                if (!isset($d['has_childs'])) {
                    $d['has_childs'] = !empty($children[$d['nid']]);
                }
                $d['loaded'] = empty($d['has_childs']);
            }
        }

        return $res['data'];
    }
}
