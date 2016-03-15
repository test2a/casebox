<?php
namespace SystemFolders;

use Casebox\CoreBundle\Service\Cache;
use \Casebox\CoreBundle\Service\Browser;
use Casebox\CoreBundle\Service\Util;

class Listeners
{
    /**
     * create system folders specified in created objects template config as system_folders property
     * @param  object $o
     * @return void
     */
    public function onNodeDbCreate($o)
    {
        if (!is_object($o)) {
            return;
        }
        $template = $o->getTemplate();
        if (empty($template)) {
            return;
        }

        $templateData = $template->getData();
        if (empty($templateData['cfg']['system_folders'])) {
            return;
        }

        $folderIds = Util\toNumericArray($templateData['cfg']['system_folders']);

        if (empty($folderIds)) {
            return;
        }

        $p = array(
            'sourceIds' => array()
            ,'targetId' => $o->getData()['id']
        );

        $browserActionsClass = new Browser\Actions();

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT id
            FROM tree
            WHERE pid in ('.implode(',', $folderIds).')
                AND dstatus = 0'
        );
        while ($r = $res->fetch()) {
            $p['sourceIds'][] = $r['id'];
        }
        unset($res);

        // $browserActionsClass->copy($p);

        $browserActionsClass->objectsClass = new \Casebox\CoreBundle\Service\Objects();

        $browserActionsClass->doRecursiveAction(
            'copy',
            $p['sourceIds'],
            $p['targetId']
        );
    }
}
