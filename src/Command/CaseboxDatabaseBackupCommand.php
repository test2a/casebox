<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\System;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class CaseboxDatabaseBackupCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:database:backup')
            ->setDescription('Backup database')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);

        $container = $this->getContainer();

        // Bootstrap
        $system = new System();
        $system->bootstrap($container);

        $dbHost = $container->getParameter('db_host');
        $dbPort = $container->getParameter('db_port');
        $dbUser = $container->getParameter('db_user');
        $dbPass = $container->getParameter('db_pass');
        $dbName = $container->getParameter('db_name');
        
        $file = $container->getParameter('kernel.root_dir').'/../var/backup/'.$dbName.'-'.time().'.sql';
        $cmd = "mysqldump --user=$dbUser --password=$dbPass --host=$dbHost --port=$dbPort $dbName > $file";
        
        system($cmd);

        $output->success('command casebox:database:backup');
    }
}
