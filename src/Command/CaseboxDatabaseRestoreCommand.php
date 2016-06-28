<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\System;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class CaseboxDatabaseRestoreCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:database:restore')
            ->setDescription('Restore database')
            ->addOption('file', 'F', InputOption::VALUE_OPTIONAL, 'Backup file. Example default-1467108097.sql')
            ->addOption('bootstrap', 'B', InputOption::VALUE_OPTIONAL, 'Enable bootstrap. Values true or false. Default true', true)
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);

        $container = $this->getContainer();

        // Bootstrap
        $bootstrap = ($input->getOption('bootstrap') === 'false') ? false : true;
        if (!empty($bootstrap)) {
            $system = new System();
            $system->bootstrap($container);
        }

        $dbHost = $container->getParameter('db_host');
        $dbPort = $container->getParameter('db_port');
        $dbUser = $container->getParameter('db_user');
        $dbPass = $container->getParameter('db_pass');
        $dbName = $container->getParameter('db_name');

        $db = $input->getOption('file') ? $input->getOption('file') : 'cb_default.sql';

        $file = $container->getParameter('kernel.root_dir').'/../var/backup/'.$db;
        $cmd = "mysql --user=$dbUser --password=$dbPass --host=$dbHost --port=$dbPort $dbName < $file";
        
        system($cmd);

        if (!empty($bootstrap)) {
            $env = $container->getParameter('kernel.environment');
            $appDir = $container->getParameter('kernel.root_dir').'/..';
            system("php $appDir/bin/console casebox:solr:update --all=1 --env=$env");
        }

        $output->success('command casebox:database:restore');
    }
}
