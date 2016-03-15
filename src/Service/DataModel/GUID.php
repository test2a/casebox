<?php

namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;

class GUID extends Base
{
    /**
     * database table name
     * @var string
     */
    protected static $tableName = 'guids';

    /**
     * available table fields
     *
     * associative array of fieldName => type
     * that is also used for trivial validation of input values
     *
     * @var array
     */
    protected static $tableFields = array(
        'id' => 'int'
        ,'name' => 'varchar'
    );

    /**
     * add a record
     * @param  array $p associative array with table field values
     * @return int   created id
     */
    public static function create($p)
    {
        Util\raiseErrorIf(
            empty($p['name']),
            'ErroneousInputData' //' Empty name for GUID.'
        );

        return parent::create($p);
    }

    /**
     * read recods in bulk for given names
     * @param  array       $names
     * @return associative array ('name' => id)
     */
    public static function readNames($names)
    {
        $rez = array();
        $params = array();
        $dbs = Cache::get('casebox_dbs');

        for ($i = 1; $i <= sizeof($names); $i++) {
            $params[] = '$' . $i;
        }

        $sql = 'SELECT id, name
            FROM ' . static::getTableName() . '
            WHERE name in (' . implode(',', $params). ')';

        $res = $dbs->query($sql, $names);

        while ($r = $res->fetch()) {
            $rez[$r['name']] = $r['id'];
        }
        unset($res);

        return $rez;
    }

    public static function checkTableExistance()
    {
        $dbs = Cache::get('casebox_dbs');

        return $dbs->query(
            'CREATE TABLE IF NOT EXISTS `guids`(
                `id` bigint(20) unsigned NOT NULL  auto_increment ,
                `name` varchar(200) COLLATE utf8_general_ci NOT NULL  ,
                PRIMARY KEY (`id`) ,
                UNIQUE KEY `guids_name`(`name`)
            ) ENGINE=InnoDB DEFAULT CHARSET=\'utf8\' COLLATE=\'utf8_general_ci\'',
            array()
        );
    }
}
