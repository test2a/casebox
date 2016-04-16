<?php
namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;

class Templates extends Base
{
    protected static $tableName = 'templates';

    protected static $tableFields = array(
        'id' => 'int'
        ,'pid' => 'int'
        ,'is_folder' => 'int'
        ,'type' => 'varchar'
        ,'name' => 'varchar'
        // ,'l1' => 'varchar'
        // ,'l2' => 'varchar'
        // ,'l3' => 'varchar'
        // ,'l4' => 'varchar'
        ,'order' => 'int'
        ,'visible' => 'int'
        ,'iconCls' => 'varchar'
        // ,'default_field' => 'varchar' //??
        ,'cfg' => 'text'
        ,'title_template' => 'varchar'
        ,'info_template' => 'varchar'
    );

    protected static $decodeJsonFields = array('cfg');

    protected static $allowReadAll = true;

    /**
     * read all templates with data form objects table
     * @param  int     $id
     * @return boolean
     */
    public static function readAllWithData()
    {
        $rez = array();

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT t.*
                ,o.data
            FROM ' . static::getTableName() . ' t
            LEFT JOIN objects o
                ON t.id = o.id
            WHERE t.is_folder = 0'
        );

        while ($r = $res->fetch()) {
            $r['cfg'] = Util\toJSONArray($r['cfg']);
            $r['data'] = Util\toJSONArray($r['data']);

            $rez[] = $r;
        }
        unset($res);

        return $rez;
    }

    /**
     * get template ids by template type
     * @param string $type
     * @return array
     */
    public static function getIdsByType($type)
    {
        $rez = array();

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT id
            FROM templates
            WHERE `type` = $1
            ORDER BY id',
            $type
        );

        while ($r = $res->fetch()) {
            $rez[] = $r['id'];
        }
        unset($res);

        return $rez;
    }

    /**
     * copy a record
     * @param  int     $id
     * @return boolean
     */
    public static function copy($sourceId, $targetId)
    {
        $r = Tree::read($targetId);
        $pid = empty($r)
            ? null
            : $r['pid'];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'INSERT INTO ' . static::getTableName() . '
                (id,
                pid,
                `is_folder`,
                `type`,
                `name`,
                `l1`,
                `l2`,
                `l3`,
                `l4`,
                `order`,
                `visible`,
                `iconCls`,
                `default_field`,
                `cfg`,
                `title_template`,
                `info_template`)
            SELECT
                $2,
                $3,
                `is_folder`,
                `type`,
                `name`,
                `l1`,
                `l2`,
                `l3`,
                `l4`,
                `order`,
                `visible`,
                `iconCls`,
                `default_field`,
                `cfg`,
                `title_template`,
                `info_template`
            FROM ' . static::getTableName() . '
            WHERE id = $1',
            array(
                $sourceId
                ,$targetId
                ,$pid
            )
        );

        return ($res->rowCount() > 0);
    }
}
