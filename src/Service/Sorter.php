<?php

namespace Casebox\CoreBundle\Service;

/**
 * Sorters for item arrays using a sortField for sorting
 */
class Sorter
{
    /**
     * This property (field) should be set before call a sorter function
     * @var null
     */
    public static $sortField = null;

    /**
     * asDate - Converts the value into Unix epoch time
     *
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asDateAsc($a, $b)
    {
        // If supposed to be mysql date strings then we can compare them as strings
        return self::asStringAsc($a, $b);
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asDateDesc($a, $b)
    {
        return self::asDateAsc($b, $a);
    }

    /**
     * asFloat - Converts the value to a floating point number
     *
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asFloatAsc($a, $b)
    {
        $a = @floatval($a[self::$sortField]);
        $b = @floatval($b[self::$sortField]);

        if ($a < $b) {
            return -1;
        }

        if ($a > $b) {
            return 1;
        }

        return 0;
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asFloatDesc($a, $b)
    {
        return self::asFloatAsc($b, $a);
    }

    /**
     * asInt - Converts the value to an integer number
     *
     * @param string $a
     * @param string $b
     *
     * @return int
     */
    public static function asIntAsc($a, $b)
    {
        $a = @intval($a[self::$sortField]);
        $b = @intval($b[self::$sortField]);

        if ($a < $b) {
            return -1;
        }

        if ($a > $b) {
            return 1;
        }

        return 0;
    }

    /**
     * @param array $a
     * @param array  $b
     *
     * @return int
     */
    public static function asIntDesc($a, $b)
    {
        return self::asIntAsc($b, $a);
    }

    /**
     * asText - Removes any tags and converts the value to a string
     *
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asTextAsc($a, $b)
    {
        $f = self::$sortField;
        $a[$f] = @strip_tags($a[$f]);
        $b[$f] = @strip_tags($b[$f]);

        return self::asStringAsc($a, $b);
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asTextDesc($a, $b)
    {
        return self::asTextAsc($b, $a);
    }

    /**
     * asUCText - Removes any tags and converts the value to an uppercase string
     *
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asUCTextAsc($a, $b)
    {
        $f = self::$sortField;
        $a[$f] = mb_strtoupper(@strip_tags($a[$f]));
        $b[$f] = mb_strtoupper(@strip_tags($b[$f]));

        return self::asStringAsc($a, $b);
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asUCTextDesc($a, $b)
    {
        return self::asUCTextAsc($b, $a);
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asStringAsc($a, $b)
    {
        $a = @$a[self::$sortField];
        $b = @$b[self::$sortField];

        if ($a < $b) {
            return -1;
        }

        if ($a > $b) {
            return 1;
        }

        return 0;
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asStringDesc($a, $b)
    {
        return self::asStringAsc($b, $a);
    }

    /**
     * asUCString - Converts the value to an uppercase string
     *
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asUCStringAsc($a, $b)
    {
        $f = self::$sortField;
        $a[$f] = @mb_strtoupper($a[$f]);
        $b[$f] = @mb_strtoupper($b[$f]);

        $rez = self::asStringAsc($a, $b);

        return $rez;
    }

    /**
     * @param array $a
     * @param array $b
     *
     * @return int
     */
    public static function asUCStringDesc($a, $b)
    {
        return self::asUCStringAsc($b, $a);
    }
}
