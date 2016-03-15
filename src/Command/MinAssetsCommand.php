<?php

namespace Casebox\CoreBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

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
     * @param InputInterface $input
     * @param OutputInterface $output
     *
     * @return null
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $container = $this->getContainer();
        $cmd = $container->getParameter('kernel.root_dir').'/../bin/console';

        system($cmd.' casebox:min:css');
        system($cmd.' casebox:min:js');
        system($cmd.' assets:install --symlink --relative');

        $symlinks = [
            $container->getParameter('kernel.root_dir').'/../web/css',
            $container->getParameter('kernel.root_dir').'/../web/files',
            $container->getParameter('kernel.root_dir').'/../web/img',
            $container->getParameter('kernel.root_dir').'/../web/js',
            $container->getParameter('kernel.root_dir').'/../web/min',
        ];

        foreach ($symlinks as $symlink) {
            system('rm '.$symlink);
        }

        system('cd '.$container->getParameter('kernel.root_dir').'/../web;'.'ln -s bundles/caseboxcore/* .');

        $output->writeln('DONE!');
    }
}
