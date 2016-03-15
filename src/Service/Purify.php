<?php

namespace Casebox\CoreBundle\Service;

use Casebox\CoreBundle\Service\Config;

/**
 * Class used to purify values
 */
class Purify
{
    /**
     * @var array|Singleton|null
     */
    protected static $_instance = null;

    /**
     * @var string|array|null
     */
    protected static $purifier = null;

    /**
     * Prevent direct object creation
     */
    final private function __construct()
    {
        require_once Config::get('HTML_PURIFIER');
        require_once 'HTMLPurifier.func.php';

        //create default config
        $config = \HTMLPurifier_Config::createDefault();

        $config->set('AutoFormat.AutoParagraph', false);
        $config->set('AutoFormat.RemoveEmpty.RemoveNbsp', true);
        $config->set('HTML.ForbiddenElements', ['head']);
        $config->set('HTML.SafeIframe', true);
        $config->set('HTML.TargetBlank', true);
        $config->set('URI.DefaultScheme', 'https');
        $config->set('Attr.EnableID', true);

        static::$purifier = new \HTMLPurifier($config);
    }

    /**
     * Prevent object cloning
     */
    final private function __clone()
    {
    }

    /**
     * Returns new or existing Singleton instance
     * @return Singleton
     */
    final public static function getInstance()
    {
        if (null !== static::$_instance) {
            return static::$_instance;
        }
        static::$_instance = new static();

        return static::$_instance;
    }

    /**
     * Purify given html value
     *
     * @param  string $value
     * @param  array $options associative array of purify library options
     *
     * @return string
     */
    final public static function html($value, $options = [])
    {
        if (empty($value)) {
            return '';
        }

        static::getInstance();

        $value = Util\toUTF8String($value);

        $config = null;
        if (!empty($options)) {
            $config = \HTMLPurifier_Config::createDefault();

            foreach ($options as $k => $v) {
                $config->set($k, $v);
            }
        }

        $value = static::$purifier->purify($value, $config);

        Cache::remove('memory');

        return $value;
    }

    /**
     * Purify filename by removing unsuported filesystem chars: \ / : * ? " < > |
     *
     * @param string $fielname
     *
     * @return string
     */
    final public static function filename($filename)
    {
        // replace not allowed chars
        $filename = preg_replace('/[\\\\\/:\*\?"<>|\n\r\t]/', '', $filename);
        // replace more spaces with one space
        $filename = preg_replace('/\s+/', ' ', $filename);

        $filename = trim($filename);

        return $filename;
    }

    /**
     * Purify Solr field name
     *
     * @param  string $name
     *
     * @return string
     */
    final public static function solrFieldName($name)
    {
        $name = preg_replace('/[^a-z\d_]/i', '', $name);

        return $name;
    }

    /**
     * Purify human name
     *
     * @param string $name
     *
     * @return string
     */
    final public static function humanName($name)
    {
        // replace not allowed chars
        $name = preg_replace('/[^\w\s\."\'`\-]/iu', '', $name);
        // replace more spaces with one space
        $name = preg_replace('/\s+/', ' ', $name);

        $name = trim($name);

        return $name;
    }
}
