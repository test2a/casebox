<?php

namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\User;

/**
 * Class Favorites
 */
class Favorites extends Base
{
    /**
     * database table name
     * @var string
     */
    protected static $tableName = 'favorites';

    /**
     * available table fields
     *
     * associative array of fieldName => type
     * that is also used for trivial validation of input values
     *
     * @var array
     */
    protected static $tableFields = [
        'id' => 'int',
        'user_id' => 'int',
        'node_id' => 'varchar',
        'data' => 'text',
    ];

    protected static $decodeJsonFields = ['data'];

    public static function readAll()
    {
        $rez = [];

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query(
            'SELECT * FROM '.static::getTableName().' WHERE user_id = $1', User::getId()
        );

        while ($r = $res->fetch()) {
            static::decodeJsonFields($r);
            $rez[] = $r;
        }
        unset($res);

        return $rez;
    }

    public static function deleteByNodeId($nodeId, $userId = false)
    {
        if ($userId == false) {
            $userId = \Casebox\CoreBundle\Service\User::getId();
        }

        $dbs = Cache::get('casebox_dbs');

        $res = $dbs->query('DELETE FROM '.static::getTableName().' WHERE user_id = $1 AND node_id = $2',
            [
                $userId
                ,
                $nodeId,
            ]
        );

        $rez = ($res->rowCount() > 0);

        return $rez;
    }
}
