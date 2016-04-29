<?php
namespace Casebox\CoreBundle\Service\DataModel;

use Casebox\CoreBundle\Service\Cache;

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
        $configService = Cache::get('symfony.container')->get('casebox_core.service.config');

        $dbName = $configService->get('prefix') . '__casebox';

        return "`$dbName`.`" . static::$tableName . '`';
    }
}
