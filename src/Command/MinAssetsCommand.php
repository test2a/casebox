<?php

namespace Casebox\CoreBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Filesystem\Filesystem;

/**
 * Class MinAssetsCommand
 */
class MinAssetsCommand extends ContainerAwareCommand
{
    /**
     * Configure
     */
    protected function configure()
    {
        $this
            ->setName('casebox:min:assets')
            ->setDescription('Minify CSS and JS files.');
    }

    /**
     * @param InputInterface  $input
     * @param OutputInterface $output
     *
     * @return null
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $container = $this->getContainer();
        $cmd = 'php ' . $container->getParameter('kernel.root_dir').'/../bin/console';

        system($cmd.' casebox:min:css');
        system($cmd.' casebox:min:js');

        $symlinks = [
            'css' => $container->getParameter('kernel.root_dir').'/../web/css',
            'files' => $container->getParameter('kernel.root_dir').'/../web/files',
            'img' => $container->getParameter('kernel.root_dir').'/../web/img',
            'js' => $container->getParameter('kernel.root_dir').'/../web/js',
            'min' => $container->getParameter('kernel.root_dir').'/../web/min',
        ];

        $fs = new Filesystem();

        foreach ($symlinks as $key => $symlink) {
            if ($fs->exists([$symlink])) {
                continue;
            }

            system('rm '.$symlink);

            $src = 'bundles/caseboxcore/'.$key;

            $dst = $symlink;

            $output->writeln(sprintf("<info>[*] Add '%s' symlink.</info>", $symlink));

            $fs->symlink($src, $dst);

            $output->writeln(sprintf("<info>[x] Symlink '%s' added.</info>", $symlink));
        }

        $output->writeln('<info>[x] Casebox assets installed.</info>');
    }
}
