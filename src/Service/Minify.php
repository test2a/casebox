<?php
namespace Casebox\CoreBundle\Service;

use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Minify
 */
class Minify
{
    /**
     * @var Container
     */
    private $container;

    /**
     * Authentication constructor
     */
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    /**
     * generates minified files
     * @param  varchar         $groupName css|js
     * @param  OutputInterface $output
     * @return void
     */
    public function execute($groupName, OutputInterface $output = null)
    {
        $kernerRootDir = $this->container->getParameter('kernel.root_dir');
        define('MINIFY_MIN_DIR', $kernerRootDir . '/../vendor/mrclay/minify/min/');

        // set config path defaults
        $min_configPaths = array(
            'base'   => MINIFY_MIN_DIR . '/config.php',
            'test'   => MINIFY_MIN_DIR . '/config-test.php',
            'groups' => __DIR__ . '/../Command/source/groupsConfig.php'
        );

        // load config
        require $min_configPaths['base'];

        require_once "$min_libPath/Minify/Loader.php";
        \Minify_Loader::register();

        $min_documentRoot = realpath(__DIR__ . '/..') . '/Resources/public/';

        $_SERVER['DOCUMENT_ROOT'] = $min_documentRoot;
        \Minify::$isDocRootSet = true;

        $_SERVER['REQUEST_URI'] = '/';
        $_SERVER['QUERY_STRING'] = '';

        $min_serveOptions['minApp']['groups'] = (require $min_configPaths['groups']);

        if (! isset($min_serveController)) {
            $min_serveController = new \Minify_Controller_MinApp();
        }

        foreach ($min_serveOptions['minApp']['groups'] as $group => $files) {
            $content = '';
            $ext = (substr($group, 0, 2) == 'js')
                ? 'js'
                : 'css';
            if ($ext !== $groupName) {
                continue;
            }

            if ($output) {
                $output->writeln($group);
            }

            $_GET['g'] = $group;
            $min_serveOptions['debug'] = false;

            ob_start();
            \Minify::serve($min_serveController, $min_serveOptions);
            $content = ob_get_clean();

            file_put_contents($min_documentRoot . 'min/' . $group . ".$ext", $content);

            $min_serveOptions['debug'] = true;

            ob_start();
            \Minify::serve($min_serveController, $min_serveOptions);
            $content = ob_get_clean();

            file_put_contents($min_documentRoot . 'min/' . $group . "-debug.$ext", $content);

            unset($_GET['debug']);
        }

    }
}
