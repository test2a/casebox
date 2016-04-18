<?php
namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;

/**
 * Class Config
 */
class Config extends Base
{
    /**
     * @var bool
     */
    protected static $allowReadAll = true;

    /**
     * database table name
     * @var string
     */
    protected static $tableName = 'config';

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
        'pid' => 'int',
        'param' => 'varchar',
        'value' => 'text',
        'order' => 'int',
    ];

    /**
     * @return array
     */
    public static function readAll()
    {
        $rez = [];
        $sql = 'SELECT * FROM '.static::getTableName().' ORDER BY pid';
        $dbs = Cache::get('casebox_dbs');
        $res = $dbs->query($sql.', `order`'); //order by 'order' field also
        // backward compatibility
        if (empty($res)) {
            $res = $dbs->query($sql);
        }
        while ($r = $res->fetch()) {
            $rez[] = $r;
        }
        unset($res);

        return $rez;
    }
}
