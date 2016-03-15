<?php

namespace Casebox\CoreBundle\Service\Browser;

use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Search;
use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Cache;

/**
 * Class CreateMenu
 */
class CreateMenu
{
    /**
     * get the menu config for a given path or id
     *
     * @param string|int $path path string or node id
     *
     * @return array
     */
    public static function getMenuForPath($path)
    {
        $rez = '';

        // Get item path if id specified
        if (is_numeric($path)) {
            $tmp = \Casebox\CoreBundle\Service\Path::getPath($path);
            $path = '/'.$tmp['path'];
        }

        if (is_string($path)) {
            $path = explode('/', $path);
        }

        $path = array_reverse(array_filter($path, 'is_numeric'));
        $path = Util\toNumericArray($path);

        // Get templates for each path elements
        $nodeTemplate = [];

        $recs = DM\Tree::readByIds($path);
        foreach ($recs as $r) {
            $nodeTemplate[$r['id']] = $r['template_id'];
        }

        // Get db menu into variable
        $menu = static::getMenuRules();

        $user = Cache::get('session')->get('user');
        $ugids = isset($user['groups'])
            ? $user['groups']
            : [];

        $ugids[] = $user['id'];

        // we have 3 main criterias for detecting needed menu:
        //  - user_group_ids - records for specific users or groups
        //  - node_ids
        //  - template_ids
        //
        // we'll iterate the path from the end and detect the menu

        $lastWeight = 0;
        for ($i = 0; $i < sizeof($path); $i++) {
            // Firstly we'll check if we find a menu row with id or template of the node
            foreach ($menu as $m) {
                $weight = 0;

                if (in_array($path[$i], $m['nids'])) {
                    $weight += 50;
                } elseif (empty($m['nids'])) {
                    $weight += 1;
                } else {
                    // Skip this record because it contain nids and not contain this node id
                    continue;
                }

                if (in_array($nodeTemplate[$path[$i]], $m['ntids'])) {
                    $weight += 50;
                } elseif (empty($m['ntids'])) {
                    $weight += 1;
                } else {
                    // Skip this record because it has ntids specified and not contain this node template id
                    continue;
                }

                if (empty($m['ugids'])) {
                    $weight += 1;
                } else {
                    $int = array_intersect($ugids, $m['ugids']);
                    if (empty($int)) {
                        continue;
                    } else {
                        $weight += 10;
                    }
                }

                if ($weight > $lastWeight) {
                    $lastWeight = $weight;
                    $rez = $m['menu'];
                }
            }
            // If nid matched or template matched then dont iterate further
            if ($lastWeight > 50) {
                return $rez;
            }
        }

        return $rez;
    }

    /**
     * @return array|null|\PDO|string
     */
    protected static function getMenuRules()
    {
        $rez = Cache::get('CreateMenuRules', []);

        if (!empty($rez)) {
            return $rez;
        }

        $s = new Search();
        $ids = [];

        $sr = $s->query(
            [
                'fl' => 'id',
                'template_types' => 'menu',
                'skipSecurity' => true,
            ]
        );

        foreach ($sr['data'] as $r) {
            $ids[] = $r['id'];
        }

        $arr = Objects::getCachedObjects($ids);

        foreach ($arr as $o) {
            $d = $o->getData()['data'];
            $rez[] = [
                'nids' => empty($d['node_ids']) ? [] : Util\toNumericArray($d['node_ids']),
                'ntids' => empty($d['template_ids']) ? [] : Util\toNumericArray($d['template_ids']),
                'ugids' => empty($d['user_group_ids']) ? [] : Util\toNumericArray($d['user_group_ids']),
                'menu' => $d['menu'],
            ];
        }

        Cache::set('CreateMenuRules', $rez);

        return $rez;
    }
}
