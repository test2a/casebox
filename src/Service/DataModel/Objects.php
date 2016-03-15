<?php

namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;

class Objects extends Base
{
    protected static $tableName = 'objects';

    protected static $tableFields = array(
        'id' => 'int'
        ,'data' => 'text'
        ,'sys_data' => 'text'
    );

    protected static $decodeJsonFields = array('data', 'sys_data');

    /**
     * read all data for given ids in bulk manner
     * @param  array $ids
     * @return array
     */
    public static function readAllData($ids)
    {
        $rez = array();
        $ids = Util\toNumericArray($ids);

        if (!empty($ids)) {
            $dbs = Cache::get('casebox_dbs');

            $sql = 'SELECT t.*
                    ,ti.pids
                    ,ti.path
                    ,ti.case_id
                    ,ti.acl_count
                    ,ti.security_set_id
                    ,o.data
                    ,o.sys_data
                FROM tree t
                JOIN tree_info ti
                    ON t.id = ti.id
                LEFT JOIN objects o
                    ON t.id = o.id
                WHERE t.id in (' . implode(',', $ids) .')';

            $res = $dbs->query($sql);

            while ($r = $res->fetch()) {
                $r['data'] = Util\jsonDecode($r['data']);
                $r['sys_data'] = Util\jsonDecode($r['sys_data']);
                $rez[] = $r;
            }
            unset($res);
        }

        return $rez;
    }

    /**
     * check if the record with given id is marked as draft
     * @param  int     $id
     * @return boolean
     */
    public static function isDraft($id)
    {
        $rez = false;

        $r = static::read($id);

        if (!empty($r[0]['draft']) && ($r[0]['draft'] != 0)) {
            $rez = true;
        }

        return $rez;
    }

    /**
     * copy a record
     * @param  int     $id
     * @return boolean
     */
    public static function copy($sourceId, $targetId)
    {
        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'INSERT INTO `objects`
                (`id`
                ,`data`
                ,`sys_data`)
            SELECT
                $2
                ,`data`
                ,`sys_data`
            FROM `objects`
            WHERE id = $1',
            array(
                $sourceId
                ,$targetId
            )
        );

        return ($res->rowCount() > 0);
    }
}
