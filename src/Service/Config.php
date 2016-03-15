<?php

namespace Casebox\CoreBundle\Service;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Traits\TranslatorTrait;

/**
 * Class Config
 */
class Config extends Singleton
{
    use TranslatorTrait;

    /**
     * @var array
     */
    protected static $config = [];

    /**
     * @var array
     */
    protected static $environmentVars = [];

    /**
     * @var array
     */
    protected static $plugins = [];

    /**
     * @var int
     */
    public static $CORESTATUS_DISABLED = 0;

    /**
     * @var int
     */
    public static $CORESTATUS_ACTIVE = 1;

    /**
     * @var int
     */
    public static $CORESTATUS_MAINT = 2;

    /**
     * @var array
     */
    protected static $flags = [
        'disableTriggers' => false,
        'disableSolrIndexing' => false,
        'disableActivityLog' => false,
    ];

    /**
     * Method for loading core config
     *
     * @param array $cfg default configuration
     *
     * @return array throw an exception if core is not defined in db
     */
    public static function load($cfg = [])
    {
        // Merging configs from platform, from casebox database and from core itself
        $cfg = array_merge($cfg, static::getPlatformDBConfig());
        $cfg = array_merge($cfg, static::getPlatformConfigForCore($cfg['coreName']));

        $coreDBConfig = static::getCoreDBConfig();

        $propertiesToMerge = ['files'];

        // Detect available languages
        $languages = empty($coreDBConfig['languages']) ? $cfg['languages'] : $coreDBConfig['languages'];

        //prepare language properties to be decoded and merged
        $languages = explode(',', $languages);
        foreach ($languages as $l) {
            $l = 'language_'.$l;
            if (isset($cfg[$l])) {
                $cfg[$l] = Util\toJSONArray($cfg[$l]);
            }
            if (isset($coreDBConfig[$l])) {
                $coreDBConfig[$l] = Util\toJSONArray($coreDBConfig[$l]);
            }
            $propertiesToMerge[] = $l;
        }

        $cfg = static::mergeConfigs($cfg, $coreDBConfig, $propertiesToMerge);

        static::$config = static::adjustConfig($cfg);
        static::$environmentVars = static::getEnvironmentVars(static::$config);

        // Set max file version count
        if (isset(static::$config['files']['max_versions'])) {
            __autoload('Casebox\\CoreBundle\\Service\\Files');
            Files::setMFVC(static::$config['files']['max_versions']);
        } elseif (isset(static::$config['max_files_version_count'])) { //backward compatibility check
            __autoload('Casebox\\CoreBundle\\Service\\Files');
            Files::setMFVC(static::$config['max_files_version_count']);
        }

        ini_set('error_log', static::$environmentVars['error_log']);

        return static::$config;
    }

    /**
     * Reading configuration file
     * @return array
     */
    public static function loadConfigFile($filename)
    {
        if (file_exists($filename)) {
            $rez = parse_ini_file($filename);
        } else {
            throw new \Exception('Can\t load config file: '.$filename, 1);
        }

        return $rez;
    }

    /**
     * get casebox config stored in database
     *
     * TODO: remove this method after config migration
     * @return array
     */
    public static function getPlatformDBConfig()
    {
        $rez = [];

        // $recs = DM\GlobalConfig::readAll();

        // foreach ($recs as $r) {
        //     if (!empty($r['pid'])) {
        //         $rez[$r['param']] = $r['value'];
        //     }
        // }
        return $rez;
    }

    /**
     * get core config stored in casebox.cores table
     *
     * @return array
     */
    public static function getPlatformConfigForCore($coreName)
    {
        $rez = [];

        // $r = DM\Core::read($coreName);

        // if (isset($r['cfg'])) {
        //     $rez = $r['cfg'];
        //     $rez['core_id'] = $r['id'];
        //     $rez['core_status'] = $r['active'];

        // } else {
        //     trigger_error(
        //         "ERROR: Config::getPlatformConfigForCore(" . $coreName . ") cfg=" . print_r($r, true),
        //         E_USER_WARNING
        //     );
        //     // throw new \Exception('Error getting core config', 1);
        // }
        return $rez;
    }

    /**
     * get core config stored in database
     *
     * TODO: remove this method after config migration
     * @return array
     */
    private static function getCoreDBConfig()
    {
        $rez = [];

        $ref = [];
        $left = [];
        $lastLength = 0;

        $rows = DM\Config::readAll();

        //add root nodes
        foreach ($rows as &$r) {
            if (empty($r['pid'])) {
                $ref[$r['id']] = &$r;
            } else {
                $left[] = &$r;
            }
        }

        while (!empty($left) && (sizeof($left) != $lastLength)) {
            $rows = $left;
            $lastLength = sizeOf($left);
            $left = [];

            foreach ($rows as &$r) {
                if (isset($ref[$r['pid']])) {
                    $p = &$ref[$r['pid']];
                    if (!is_array($p['value'])) {
                        $p['value'] = Util\toJSONArray($p['value']);
                    }

                    $r['value'] = Util\toJSONArray($r['value']);
                    $p['value'][$r['param']] = &$r['value'];
                    $ref[$r['id']] = &$r;

                } else {
                    $left[] = &$r;
                }
            }
        }

        //iterate and collect resulting items
        foreach ($ref as &$r) {
            if (empty($r['pid'])) {
                $rez[$r['param']] = $r['value'];
            }
        }

        return $rez;
    }

    /**
     * get project name from config
     * if cannot be found - coreName is returned
     * @return string
     */
    public static function getProjectName()
    {
        $userLanguage = Config::get('user_language', 'en');

        $rez = static::get('project_name_'.$userLanguage);

        if (empty($rez)) {
            $rez = static::get('project_name');
        }

        if (empty($rez)) {
            $rez = static::get('project_name_en');
        }

        if (empty($rez)) {
            $rez = static::get('coreName');
        }

        return $rez;
    }

    /**
     * get environment variables from given config
     * @return array
     */
    private static function getEnvironmentVars($config)
    {
        $coreName = $config['coreName'];
        $ds = DIRECTORY_SEPARATOR;

        //$this->container->getParameter(
        $filesDir = $config['cb_files_dir'].$ds;

        $rez = [
            'db_name' => empty($config['db_name']) ? $config['prefix'].$coreName : $config['db_name'],
            'solr_core' => empty($config['solr_core']) ? $config['prefix'].$coreName : $config['solr_core'],
            // path to files folder
            'files_dir' => $filesDir,
            'files_preview_dir' => $filesDir.'preview'.$ds,
            'photos_path' => $filesDir.'_photo'.$ds,
            'core_url' => $config['server_name'].'c/'.$coreName.'/',
            'core_uri' => '/c/'.$coreName.'/',
            //'upload_temp_dir' => TEMP_DIR . $coreName . $ds,
            /* path to incomming folder. In this folder files are stored when just uploaded
            and before checking existance in target.
            If no user intervention is required then files are stored in db. */
            'incomming_files_dir' => $filesDir.'incomming'.$ds,
            'error_log' => $config['cb_logs_dir'].'/'.$coreName.'_custom.log',
            // custom Error log per Core, use it for debug/reporting purposes
            'debug_log' => $config['cb_logs_dir'].'/'.$coreName.'_debug.log',
        ];

        // Define folder templates
        $rez['folder_templates'] = empty($config['folder_templates']) ? [] : explode(',', $config['folder_templates']);

        $rez['default_folder_template'] = empty($rez['folder_templates']) ? 0 : $rez['folder_templates'][0];

        if (empty($config['default_file_template'])) {
            $a = DM\Templates::getIdsByType('file');
            $rez['default_file_template'] = array_shift($a);
        } else {
            $rez['default_file_template'] = $config['default_file_template'];
        }

        if (empty($config['default_shortcut_template'])) {
            $a = DM\Templates::getIdsByType('shortcut');
            $rez['default_shortcut_template'] = array_shift($a);
        } else {
            $rez['default_shortcut_template'] = $config['default_shortcut_template'];
        }

        /* Define Core available languages */
        // $rez['languages'] = implode(',', array_keys($rez['language_settings']));

        // if (!empty($config['languages'])) {
        //     $rez['languages'] = Util\toTrimmedArray($config['languages']);

        //     // define default core language
        //     $rez['language'] = (
        //             empty($config['default_language']) ||
        //             !in_array($config['default_language'], $rez['languages'])
        //         )
        //         ? $rez['languages'][0]
        //         : $config['default_language'];
        // }

        $rez['languages'] = empty($config['languages']) ? ['en'] : Util\toTrimmedArray($config['languages']);

        if (empty($config['languagesUI'])) {
            $rez['languagesUI'] = $rez['languages'];
        } else {
            $rez['languagesUI'] = Util\toTrimmedArray($config['languagesUI']);
        }

        $rez['max_rows'] = empty($config['max_rows']) ? 50 : $config['max_rows'];

        return $rez;
    }

    /**
     * set an environment core varibale
     *
     * @param string $varName
     * @param array $value
     */
    public static function setEnvVar($varName, $value)
    {
        static::$environmentVars[$varName] = $value;
    }

    /**
     * get defined plugins for right panel for given object type
     *
     * @param string $objectType
     * @param string $from defines subgroup plugin definition (window - object edit window)
     *
     * @return array
     */
    public static function getObjectTypePluginsConfig($objectType, $from = '')
    {
        $rez = [];
        $tmp = static::get('object_type_plugins');

        if (!empty($from)) {
            $tmp = @$tmp[$from];
        }

        if (!empty($tmp[$objectType])) {
            $rez = $tmp[$objectType];
        } else {
            $tmp = static::get('default_object_plugins');

            if (!empty($from)) {
                $tmp = @$tmp[$from];
            }

            if (!empty($tmp)) {
                $rez = $tmp;
            }
        }

        return $rez;
    }

    /**
     * return default columns available for griv view
     * @return array
     */
    public static function getDefaultGridViewColumns()
    {
        $instance = static::getInstance();

        if (empty($instance->defaultGridViewColumns)) {
            $instance->defaultGridViewColumns = [
                'nid' => 'ID',
                'name' => self::trans('Name'),
                'path' => self::trans('Path'),
                'case' => self::trans('Project'),
                'date' => self::trans('Date'),
                'size' => self::trans('Size'),
                'cid' => self::trans('Creator'),
                'oid' => self::trans('Owner'),
                'uid' => self::trans('UpdatedBy'),
                'comment_user_id' => self::trans('CommentedBy'),
                'cdate' => self::trans('CreatedDate'),
                'udate' => self::trans('UpdatedDate'),
                'comment_date' => self::trans('CommentedDate'),
                'date_end' => self::trans('EndDate'),
            ];
        }

        return $instance->defaultGridViewColumns;
    }

    /**
     * return default configs for known grid columns
     * @return array
     */
    public static function getDefaultGridColumnConfigs()
    {
        $instance = static::getInstance();

        if (empty($instance->defaultGridColumnConfigs)) {
            $userConfig = &Cache::get('session')->get('user')['cfg'];
            $dateFormat = $userConfig['short_date_format'];
            $dateTimeFormat = $dateFormat.' '.$userConfig['time_format'];

            $instance->defaultGridColumnConfigs = [
                'nid' => [
                    'title' => 'ID',
                    'width' => 80,
                ],
                'name' => [
                    'title' => self::trans('Name'),
                    'width' => 300,
                ],
                'path' => [
                    'title' => self::trans('Path'),
                    'width' => 150,
                ],
                'case' => [
                    'title' => self::trans('Project'),
                    "solr_column_name" => "case_id",
                    "fieldType" => "_objects",
                    'width' => 150,
                ],
                'date' => [
                    'title' => self::trans('Date'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'size' => [
                    'title' => self::trans('Size'),
                    'width' => 80,
                ],
                'cid' => [
                    'title' => self::trans('Creator'),
                    'width' => 200,
                ],
                'oid' => [
                    'title' => self::trans('Owner'),
                    'width' => 200,
                ],
                'uid' => [
                    'title' => self::trans('UpdatedBy'),
                    'width' => 200,
                ],
                'did' => [
                    'title' => self::trans('DeletedBy'),
                    'width' => 200,
                ],
                'comment_user_id' => [
                    'title' => self::trans('CommentedBy'),
                    'width' => 200,
                ],
                'cdate' => [
                    'title' => self::trans('CreatedDate'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'udate' => [
                    'title' => self::trans('UpdatedDate'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'ddate' => [
                    'title' => self::trans('DeletedDate'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'comment_date' => [
                    'title' => self::trans('CommentedDate'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'date_end' => [
                    'title' => self::trans('EndDate'),
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'order' => [
                    'title' => self::trans('Order'),
                    //we shouldnt set solr_column_name by default
                    //because there are templates that could extract values from objects
                    // ,'solr_column_name' => 'order'
                    "align" => "center",
                    "width" => 10,
                    "columnWidth" => 10,

                ],
                'task_u_assignee' => [
                    'title' => self::trans('Assignee'),
                    'width' => 200,
                ],
                'task_u_started' => [
                    'title' => self::trans('StartedBy'),
                    'width' => 200,
                ],
                'task_u_ongoing' => [
                    'title' => self::trans('Ongoing'),
                    'width' => 200,
                ],
                'task_u_done' => [
                    'title' => self::trans('DoneBy'),
                    'width' => 200,
                ],
                'task_u_blocker' => [
                    'title' => self::trans('Blocker'),
                    'width' => 200,
                ],
                'task_u_all' => [
                    'title' => self::trans('All'),
                    'width' => 200,
                ],
                'task_d_closed' => [
                    'title' => self::trans('ClosedDate'),
                    "solr_column_name" => "task_d_closed",
                    'width' => 130,
                    'xtype' => 'datecolumn',
                    'format' => $dateTimeFormat,
                ],
                'task_status' => [
                    'title' => self::trans('Status'),
                    'width' => 70,
                ],
            ];
        }

        return $instance->defaultGridColumnConfigs;
    }

    private static function adjustConfig($cfg)
    {
        //facet definitions defined globally in casebox config
        $dfd = [];

        if (!empty($cfg['default_facet_configs'])) {
            $dfd = Util\toJSONArray($cfg['default_facet_configs']);
            unset($cfg['default_facet_configs']);
        }

        //check if have defined facets in core config
        if (!empty($cfg['facet_configs'])) {
            $dfd = array_merge($dfd, Util\toJSONArray($cfg['facet_configs']));
        }
        $cfg['facet_configs'] = $dfd;

        //transform boolean properties to boolean
        $boolProperties = [
            'allow_duplicates',
        ];

        foreach ($boolProperties as $property) {
            if (isset($cfg[$property])) {
                $cfg[$property] = in_array($cfg[$property], ['true', true, 'y', 1, '1'], true);
            }
        }
        //end of transform boolean properties to boolean

        // detect core plugins (use defined or default if set)
        $plugins = [];
        if (!empty($cfg['default_plugins'])) {
            $plugins = $cfg['default_plugins'];
        }
        if (!empty($cfg['plugins'])) {
            $plugins = Util\toJSONArray($cfg['plugins']);
        }
        $cfg['plugins'] = $plugins;
        // end of detect plugins

        //decode properties of the core config that should be json
        $jsonProperties = [
            'api',
            'css',
            'comments_config',
            'files',
            'js',
            'plugins',
            'listeners',
            'node_facets',
            'node_DC',
            'default_DC',
            'search_DC',
            'default_object_plugins',
            'object_type_plugins',
            'treeNodes',
            'action_log',
            'maintenance',
            'leftRibbonButtons',
        ];

        foreach ($jsonProperties as $property) {
            if (!empty($cfg[$property])) {
                $arr = Util\toJSONArray($cfg[$property]);

                if (!empty($arr)) {
                    $cfg[$property] = $arr;

                } elseif (substr($property, -3) !== '_DC') { //_DC's could have reference to predefined config sets
                    Cache::get('symfony.container')->get('logger')->error(
                        $cfg['coreName'].': Error parsing json config for property "'.$property.'".'
                    );
                }
            }
        }

        return $cfg;
    }

    /**
     * extend the given $customization from value set in $cutomization["extends"] if present under container
     *
     * @param string $container
     * @param array $customization
     *
     * @return array
     */
    public static function extend($container, $customization)
    {
        $rez = $customization;

        if (!empty($rez['extends'])) {
            $container = static::get($container);

            if (!empty($container[$rez['extends']])) {
                $rez = array_merge($container[$rez['extends']], $rez);
                unset($rez['extends']);
            }
        }

        return $rez;
    }

    /**
     *
     * @param string $optionName name of the option to get
     *
     * @return array | null
     */
    public static function get($optionName, $defaultValue = null)
    {
        if (isset(static::$environmentVars[$optionName])) {
            return static::$environmentVars[$optionName];
        }

        if (isset(static::$config[$optionName])) {
            return static::$config[$optionName];
        }

        return $defaultValue;
    }

    public static function getDCConfig($alias)
    {
        $rez = [];
        $conf = static::get('DCConfigs');

        if (!empty($conf[$alias])) {
            $rez = $conf[$alias];
        }

        return $rez;
    }

    /**
     * get flag value
     *
     * @param string $name flag name
     *
     * @return array return false if not set
     */
    public static function getFlag($name)
    {
        if (isset(static::$flags[$name])) {
            return static::$flags[$name];
        }

        return false;
    }

    /**
     * set flag value
     *
     * @param string $name
     * @param array $value
     *
     * @return array return false if not set
     */
    public static function setFlag($name, $value)
    {
        static::$flags[$name] = $value;
    }

    /**
     * Custom function for merging two config arrays
     * This function takes as third param an array of properties that should be merged separately
     * It's evident that these properties should have array values in configs
     *
     * @param array $cfg1
     * @param array $cfg2
     * @param array $properties
     *
     * @return array
     */
    public static function mergeConfigs($cfg1, $cfg2, $properties)
    {
        foreach ($cfg2 as $k => $v) {
            if (in_array($k, $properties) && is_array($v)) {
                if (empty($cfg1[$k])) {
                    $cfg1[$k] = [];
                }
                $cfg1[$k] = array_merge($cfg1[$k], $cfg2[$k]);
            } else {
                $cfg1[$k] = $v;
            }
        }

        return $cfg1;
    }
}
