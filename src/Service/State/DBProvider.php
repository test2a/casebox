<?php

namespace Casebox\CoreBundle\Service\State;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Path;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;

/**
 * Class DBProvider
 *
 * Class for saving/reading interface state for the current user
 */
class DBProvider
{
    /**
     * Read current user state
     * @return array
     */
    public function read()
    {
        $result = [
            'success' => true,
            'data' => User::getUserConfigParam('state', []),
        ];

        return $result;
    }

    /**
     * Set state
     *
     * @param array $p
     *
     * @return array
     */
    public function set($p)
    {
        if (User::isLogged()) {
            $result = ['success' => true];

            $state = User::getUserConfigParam('state', []);

            if (!empty($p['value']) || isset($state[$p['name']])) {
                if (empty($p['value'])) {
                    unset($state[$p['name']]);
                } else {
                    $state[$p['name']] = $p['value'];
                }

                User::setUserConfigParam('state', $state);
            }
        } else {
            $result = ['success' => false];
        }

        return $result;
    }

    /**
     * Save state for grid view of the browser
     * @return array
     */
    public function saveGridViewState($p)
    {
        $result = ['success' => true];
        $guid = false;

        $dbs = Cache::get('casebox_dbs');

        if (!empty($p['params']['search']['template_id'])) {
            $guid = 'template_'.$p['params']['search']['template_id'];
        } elseif (!empty($p['params']['query'])) {
            $guid = 'search';
        } else {
            $path = empty($p['params']['path']) ? $p['params']['id'] : $p['params']['path'];

            if (!empty($path)) {
                $configService = Cache::get('symfony.container')->get('casebox_core.service.config');
                $treeNodeConfigs = $configService->get('treeNodes', ['Dbnode' => []]);

                $treeNodeClasses = Path::getNodeClasses($treeNodeConfigs);
                $treeNodeGUIDConfigs = [];
                foreach ($treeNodeClasses as $nodeClass) {
                    $cfg = $nodeClass->getConfig();
                    $treeNodeGUIDConfigs[$cfg['guid']] = $cfg;
                }
                $nodesPath = Path::createNodesPath($path, $treeNodeGUIDConfigs);
                if (!empty($nodesPath)) {
                    $lastNode = array_pop($nodesPath);

                    $DCConfig = $lastNode->getDC();

                    $guid = empty($DCConfig['from']) ? 'default' : $DCConfig['from'];
                }
            }
        }

        if ($guid) {
            $params = [
                $guid,
                User::getId(),
                Util\jsonEncode($p['state']),
            ];

            $dbs->query(
                'INSERT INTO tree_user_config (guid, user_id, cfg) VALUES($1, $2, $3) ON DUPLICATE KEY UPDATE cfg = $3',
                $params
            );
        }

        return $result;
    }

    /**
     * @param string|int $guid
     *
     * @return array
     */
    public static function getGridViewState($guid)
    {
        $result = [];

        $dbs = Cache::get('casebox_dbs');

        $params = [
            User::getId(),
            $guid,
        ];
        $res = $dbs->query('SELECT cfg FROM tree_user_config WHERE  user_id = $1 and guid = $2', $params);

        if ($r = $res->fetch()) {
            $result = Util\toJSONArray($r['cfg']);
        }
        unset($res);

        // Backward compatibility to extjs3
        if (!empty($result['sort']['field']) && empty($result['sort']['property'])) {
            $result['sort']['property'] = $result['sort']['field'];
        }

        return $result;
    }
}
