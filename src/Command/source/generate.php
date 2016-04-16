<?php
/**
 * Note: js groups doesnt generate after css ones
 * should be generated separately
 */
namespace Casebox\CoreBundle\Service;

$groups = require 'groupsConfig.php';

$minDir = dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) . '/mrclay/minify/min/';

$_SERVER['REQUEST_URI'] = '/';
$_SERVER['QUERY_STRING'] = '';

foreach ($groups as $group => $files) {
    $content = '';
    $ext = (substr($group, 0, 2) == 'js')
        ? 'js'
        : 'css';
    if ($ext !== 'css') {
        continue;
    }

    $dir = '';
    // $dir = dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . $ext . DIRECTORY_SEPARATOR;

    $_GET['g'] = $group;
    ob_start();
    include $minDir . 'index.php';
    $content = //'//' . $group . ": \n".
    ob_get_clean();

    file_put_contents($dir . $group . ".$ext", $content);

    $_GET['debug'] = 1;
    ob_start();
    include $minDir . 'index.php';
    $content = //'//' . $group . "-debug: \n".
    ob_get_clean();

    file_put_contents($dir . $group . "-debug.$ext", $content);
    unset($_GET['debug']);
}
