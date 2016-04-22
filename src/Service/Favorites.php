<?php

namespace Casebox\CoreBundle\Service;

use Casebox\CoreBundle\Service\DataModel as DM;

/**
 * Class Favorites
 */
class Favorites
{
    public function create($p)
    {
        $rez = [
            'succes' => false,
            'data' => [],
        ];

        if (empty($p['node_id']) || empty($p['data'])) {
            return $rez;
        }

        $data = [
            'name' => Purify::filename($p['data']['name']),
            'path' => $p['data']['path'],
            'pathText' => empty($p['data']['pathText']) ? '' : $p['data']['pathText'],
        ];

        if (is_numeric($p['node_id'])) {
            $data['template_id'] = Objects::getTemplateId($p['node_id']);
            $data['iconCls'] = Browser::getIcon($data);

        } elseif (!empty($p['data']['iconCls'])) {
            $data['iconCls'] = $p['data']['iconCls'];
        }

        $d = [
            'user_id' => User::getId(),
            'node_id' => $p['node_id'],
            'data' => Util\jsonEncode($data),
        ];

        $id = DM\Favorites::create($d);

        $rez = [
            'success' => true,
            'data' => [
                'id' => $id,
                'node_id' => $d['node_id'],
                'data' => $data,
            ],
        ];

        return $rez;
    }

    /**
     * @param null $p
     *
     * @return array
     */
    public function read($p = null)
    {
        $rez = [
            'succes' => true,
            'data' => [],
        ];

        $rez['data'] = DM\Favorites::readAll();

        return $rez;
    }

    /**
     * @param integer $nodeId
     *
     * @return array
     */
    public function delete($nodeId)
    {
        $rez = [
            'success' => DM\Favorites::deleteByNodeId($nodeId),
            'node_id' => $nodeId,
        ];

        return $rez;
    }
}
