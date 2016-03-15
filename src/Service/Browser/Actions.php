<?php
namespace Casebox\CoreBundle\Service\Browser;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Service\DBService;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Solr;
use Casebox\CoreBundle\Service\Security;
use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Traits\TranslatorTrait;

/**
 * Class Actions
 *
 * Class designed for actions like:
 *     - D&D
 *     - cut/copy and paste
 *     - create shortcut
 */
class Actions
{
    use TranslatorTrait;

    private $securitySetsFilter = '';

    /**
     * Validation function for action input params
     *
     * @param object $p input params
     *
     * @return boolean
     */
    private function validateParams(&$p)
    {
        if (empty($p['sourceIds']) && !empty($p['sourceData'])) {
            $p['sourceIds'] = [];
            foreach ($p['sourceData'] as $data) {
                $p['sourceIds'][] = $data['id'];
            }
        }
        if (empty($p['targetId']) && !empty($p['targetData'])) {
            $p['targetId'] = $p['targetData']['id'];
        }

        $p['sourceIds'] = array_unique(Util\toNumericArray(@$p['sourceIds']), SORT_NUMERIC);
        $p['targetId'] = intval(@$p['targetId']);

        return (!empty($p['sourceIds']) && !empty($p['targetId']));
    }

    /**
     * Function for making some trivial checks over input params
     *
     * @param object $p Input params
     *
     * @return boolean|string True on checks pass or error message
     */
    private function trivialChecks(&$p)
    {
        $dbs = Cache::get('casebox_dbs');

        // Dummy check if not pasting an object over itself
        // but maybe in this case we can make a copy of the object with prefix 'Copy of ...'
        if (!Config::get('allow_duplicates', false)) {
            $res = $dbs->query(
                'SELECT id FROM tree WHERE pid = $1 AND id IN ('.implode(',', $p['sourceIds']).')',
                $p['targetId']
            );
            if ($r = $res->fetch()) {
                return $this->trans('CannotCopyObjectToItself');
            }
            unset($res);
        }

        // Dummy check if not copying inside a child of sourceIds
        if (in_array($p['targetId'], $p['sourceIds'])) {
            return $this->trans('CannotCopyObjectInsideItself');
        }

        $r = DM\TreeInfo::read($p['targetId']);
        if (!empty($r['pids'])) {
            $pids = Util\toNumericArray($r['pids']);
            foreach ($p['sourceIds'] as $sourceId) {
                if (in_array($sourceId, $pids)) {
                    return $this->trans('CannotCopyObjectInsideItself');
                }
            }
        }

        return true;
    }

    /**
     * Function to check if any objects name from sourceIds exists in targetId
     *
     * @param int|array $sourceIds
     * @param int $targetId
     *
     * @return boolean|int False if not exists or id of existent target
     */
    private function overwriteCheck($sourceIds, $targetId)
    {
        $rez = false;

        if (Config::get('allow_duplicates', false)) {
            return $rez;
        }

        $dbs = Cache::get('casebox_dbs');

        $sourceIds = Util\toNumericArray($sourceIds);

        $res = $dbs->query(
            'SELECT t2.id
            FROM tree t1
            JOIN tree t2 ON
                t2.pid = $1 AND
                t1.name = t2.name AND
                t2.dstatus = 0
            WHERE t1.id in ('.implode(',', $sourceIds).')
                AND t1.dstatus = 0',
            $targetId
        );

        if ($r = $res->fetch()) {
            $rez = $r['id'];
        }
        unset($res);

        return $rez;
    }

    /**
     * Copy objects
     *
     * most complex method that requires many checks:
     * -   dummy checks for pasting object over itself, cycled pasting (pasting an object into some of its child)
     * -   if can read all object from sourceIds
     * -   if can write to target
     * -   if target object does not contain already a child with the same name and ask for overwriting confirmation
     * -   when overwriting – follow security rules
     *
     * @param object $p
     *
     * @return array
     *      An array response: success - true|false, pids - ids of parent objects that have changed their childs.
     */
    public function copy($p)
    {

        if (!$this->validateParams($p)) {
            return ['success' => false, 'msg' => $this->trans('ErroneousInputData')];
        }

        $msg = $this->trivialChecks($p);
        if ($msg !== true) {
            return ['success' => false, 'msg' => $msg];
        }

        // Security checks
        foreach ($p['sourceIds'] as $sourceId) {
            if (!\Casebox\CoreBundle\Service\Security::canRead($sourceId)) {
                return ['success' => false, 'msg' => $this->trans('Access_denied')];
            }
        }

        // There could be a situation when overwriting existing objects
        // and in this case we should check for update rigths on those existing objects
        if (!\Casebox\CoreBundle\Service\Security::canWrite($p['targetId'])) {
            return ['success' => false, 'msg' => $this->trans('Access_denied')];
        }

        if (empty($p['confirmedOverwrite'])) {
            if ($this->overwriteCheck($p['sourceIds'], $p['targetId']) !== false) {
                return [
                    'success' => false,
                    'confirm' => true,
                    'msg' => $this->trans('ConfirmOverwriting'),
                ];
            }
        }

        $processedIds = $this->doAction('copy', $p['sourceIds'], $p['targetId']);
        $rez = [
            'success' => !empty($processedIds),
            'processedIds' => $processedIds,
        ];

        // Solr tree Update
        $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');
        $dispatcher->dispatch('casebox.solr.ontreeupdate');

        return $rez;
    }

    /**
     * Move objects
     *
     * @param object $p
     *
     * @return array
     */
    public function move($p)
    {
        if (!$this->validateParams($p)) {
            return ['success' => false, 'msg' => $this->trans('ErroneousInputData')];
        }

        $msg = $this->trivialChecks($p);
        if ($msg !== true) {
            return ['success' => false, 'msg' => $msg];
        }

        // Security checks
        foreach ($p['sourceIds'] as $sourceId) {
            if (!Security::canRead($sourceId)) {
                return ['success' => false, 'msg' => $this->trans('Access_denied')];
            }
        }
        if (!Security::canWrite($p['targetId'])) {
            return ['success' => false, 'msg' => $this->trans('Access_denied')];
        }

        if (empty($p['confirmedOverwrite'])) {
            if ($this->overwriteCheck($p['sourceIds'], $p['targetId']) !== false) {
                return [
                    'success' => false,
                    'confirm' => true,
                    'msg' => $this->trans('ConfirmOverwriting'),
                ];
            }
        }

        $processedIds = $this->doAction('move', $p['sourceIds'], $p['targetId']);

        $rez = [
            'success' => !empty($processedIds),
            'processedIds' => $processedIds,
        ];

        // Solr tree Update
        $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');
        $dispatcher->dispatch('casebox.solr.ontreeupdate');

        return $rez;
    }

    /**
     * Internal function executing a copy or move action
     *
     * @param string $action
     * @param array $objectIds ids to be copied
     * @param int $targetId
     *
     * @return array
     * @throws \Exception
     */
    private function doAction($action, array $objectIds, $targetId)
    {
        /** @var DBService $dbs */
        $dbs = Cache::get('casebox_dbs');

        // All the copy process will be made in a single transaction
        $dbs->startTransaction();

        // get security sets to which this user has
        // read access for copy or delete access for move

        $this->securitySetsFilter = '';

        if (!Security::isAdmin()) {
            $ss = [];
            switch ($action) {
                case 'copy':
                    $ss = \Casebox\CoreBundle\Service\Security::getSecuritySets();
                    break;

                case 'move':
                    // check if the user can move, because it doesnt anctually delete the obj, but just move it
                    $ss = \Casebox\CoreBundle\Service\Security::getSecuritySets(false, 5);
                    break;
            }

            $this->securitySetsFilter = 'AND ti.security_set_id in (0'.implode(',', $ss).')';
        }

        // select only objects that current user can delete
        $accessibleIds = [];

        $res = $dbs->query(
            'SELECT t.id FROM tree t
             JOIN tree_info ti ON t.id = ti.id '.$this->securitySetsFilter.'
             WHERE t.id in ('.implode(',', $objectIds).') AND t.dstatus = 0'
        );

        while ($r = $res->fetch()) {
            $accessibleIds[] = $r['id'];
        }
        unset($res);

        if (!empty($accessibleIds)) {
            $this->objectsClass = new \Casebox\CoreBundle\Service\Objects();
            $rez = $this->doRecursiveAction($action, $accessibleIds, $targetId);
        } else {
            throw new \Exception($this->trans('Access_denied'), 1);
        }

        $dbs->commitTransaction();

        return $rez;
    }

    /**
     * Recursive objects moving or copying
     *
     * @param string $action
     * @param int|array $objectIds Source object ids
     * @param int $targetId target id
     *
     * @return array
     */
    public function doRecursiveAction($action, $objectIds, $targetId)
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        if (!is_array($objectIds)) {
            $objectIds = Util\toNumericArray($objectIds);
        }
        if (empty($objectIds)) {
            return false;
        }

        foreach ($objectIds as $objectId) {
            $newId = null;

            // check if object with same name exist in target
            $existentTargetId = $this->overwriteCheck($objectId, $targetId);

            if ($existentTargetId == false) {
                // copy by creating a new object in target or just move
                switch ($action) {
                    case 'copy':
                        $newId = $this->objectsClass->copy($objectId, $targetId);
                        break;
                    case 'move':
                        $newId = $this->objectsClass->move($objectId, $targetId);
                        break;
                }
            } else {
                switch ($action) {
                    case 'copy':
                        $newId = $this->objectsClass->copy($objectId, $targetId, $existentTargetId);
                        break;
                    case 'move':
                        $newId = $this->objectsClass->move($objectId, $targetId, $existentTargetId);
                        break;
                }
            }
            // skip childs copy if object not copied/moved
            if (empty($newId)) {
                continue;
            }
            $rez[] = $newId;
            // skip childs moving if moved object is itself
            if ($newId == $objectId) {
                continue;
            }

            // select direct childs of the objects and make a recursive call with them
            $res = $dbs->query(
                'SELECT t.id FROM tree t
                 JOIN tree_info ti ON t.id = ti.id '.$this->securitySetsFilter.'
                 WHERE t.pid = $1 AND t.dstatus = 0',
                $objectId
            );

            $childIds = [];
            while ($r = $res->fetch()) {
                $childIds[] = $r['id'];
            }
            unset($res);
            $this->doRecursiveAction($action, $childIds, $newId);
        }

        return $rez;
    }

    /**
     * create shorcut(s)
     *
     * @param object $p input params
     *
     * @return array response
     */
    public function shortcut($p)
    {
        if (!$this->validateParams($p)) {
            return ['success' => false, 'msg' => $this->trans('ErroneousInputData')];
        }
        /* security checks */
        foreach ($p['sourceIds'] as $sourceId) {
            if (!Security::canRead($sourceId)) {
                return ['success' => false, 'msg' => $this->trans('Access_denied')];
            }
        }
        if (!Security::canWrite($p['targetId'])) {
            return ['success' => false, 'msg' => $this->trans('Access_denied')];
        }

        $rez = [
            'success' => true,
            'targetId' => $p['targetId'],
            'processedIds' => [],
        ];

        $shortcutObject = new Objects\Shortcut();

        foreach ($p['sourceIds'] as $id) {
            $rez['processedIds'][] = $shortcutObject->create(
                [
                    'id' => null,
                    'pid' => $p['targetId'],
                    'target_id' => $id,
                ]
            );
        }

        // Solr tree Update
        $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');
        $dispatcher->dispatch('casebox.solr.ontreeupdate');

        return $rez;
    }
}
