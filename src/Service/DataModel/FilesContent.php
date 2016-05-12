<?php

namespace Casebox\CoreBundle\Service\DataModel;

/**
 * Class FilesContent
 */
class FilesContent extends Base
{
    /**
     * database table name
     * @var string
     */
    protected static $tableName = 'files_content';

    protected static $tableFields = [
        'id' => 'int',
        'size' => 'int',
        'pages' => 'int',
        'type' => 'varchar',
        'path' => 'varchar',
        'ref_count' => 'int',
        'parse_status' => 'int',
        'skip_parsing' => 'int',
        'md5' => 'varchar',
    ];
}
