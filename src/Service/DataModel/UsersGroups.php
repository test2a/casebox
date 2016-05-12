<?php

namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;

/**
 * Class UsersGroups
 */
class UsersGroups extends Base
{
    protected static $tableName = 'users_groups';

    protected static $tableFields = [
        'id' => 'int',
        'type' => 'int', //strict value,
        'system' => 'int', //0, 1,
        'name' => 'varchar',
        'first_name' => 'varchar',
        'last_name' => 'varchar',
        'sex' => 'char',
        'email' => 'varchar',
        'photo' => 'varchar',
        'password' => 'varchar',
        'salt' => 'varchar',
        'roles' => 'longtext',
        'recover_hash' => 'varchar',
        'language_id' => 'int',
        'cfg' => 'text',
        'data' => 'text',
        'last_action_time' => 'time',
        'enabled' => 'int',
        'cid' => 'int',
        'uid' => 'int',
        'did' => 'int',
        'ddate' => 'timestamp',
        'cdate' => 'int',
    ];

    protected static $decodeJsonFields = ['cfg', 'data'];

    protected static $allowReadAll = true;

    /**
     * method to get available user groups
     * @return array associative array: id => array(id, name, title, iconCls)
     */
    public static function getAvailableGroups()
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT id
                ,name
                ,COALESCE(first_name, name) `title`
                ,`system`
                ,`enabled`
            FROM users_groups
            WHERE TYPE = 1
            ORDER BY 3'
        );

        while ($r = $res->fetch()) {
            $rez[] = $r;
        }
        unset($res);

        return $rez;
    }

    /**
     * get available users with some basic data
     * @return array
     */
    public static function getAvailableUsers()
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT
                id
                ,name
                ,first_name
                ,last_name
                ,concat(\'icon-user-\', coalesce(sex, \'\')) `iconCls`
                ,photo
            FROM users_groups
            WHERE `type` = 2
                AND did IS NULL
            ORDER BY 2'
        );

        while ($r = $res->fetch()) {
            $rez[] = $r;
        }
        unset($res);

        return $rez;
    }

    /**
     * get associated group ids for given user(group) id
     *
     * @param  int $id
     *
     * @return array
     */
    public static function getMemberGroupIds($id)
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT DISTINCT group_id
            FROM users_groups_association
            WHERE user_id = $1',
            $id
        );

        while ($r = $res->fetch()) {
            $rez[] = $r['group_id'];
        }
        unset($res);

        return $rez;
    }

    /**
     * get associated user ids for given group id
     *
     * @param  int $id
     *
     * @return array
     */
    public static function getGroupUserIds($id)
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT user_id
            FROM users_groups_association
            WHERE group_id = $1',
            $id
        );

        while ($r = $res->fetch()) {
            $rez[] = $r['user_id'];
        }
        unset($res);

        return $rez;
    }

    /**
     * method to get users and groups display data in bulk manner (for rendering)
     * @return array associative array: id => array(id, name, title, iconCls)
     */
    public static function getDisplayData()
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $sql = 'SELECT id
            ,name
            ,trim( CONCAT(coalesce(first_name, \'\'), \' \', coalesce(last_name, \'\')) ) `title`
            ,CASE WHEN (`type` = 1) THEN \'icon-users\' ELSE CONCAT(\'icon-user-\', coalesce(sex, \'\') ) END `iconCls`
            FROM users_groups';

        $res = $dbs->query($sql);

        while ($r = $res->fetch()) {
            $rez[$r['id']] = $r;
        }
        unset($res);

        return $rez;
    }
}
