<?php
namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Config as CBConfig;

class Plugins extends Base
{
    /**
     * database table name
     * @var string
     */
    protected static $tableName = 'plugins';

    protected static $tableFields = array(
        'id' => 'int'
        ,'name' => 'varchar'
        ,'cfg' => 'text'
        ,'active' => 'int'
        ,'order' => 'int'
    );

    protected static $decodeJsonFields = array('cfg');

    protected static $allowReadAll = true;

    public static function getTableName()
    {
        $dbName = CBConfig::get('prefix') . '__casebox';

        return "`$dbName`.`" . static::$tableName . '`';
    }
}
