<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\Solr\Client;
use Casebox\CoreBundle\Service\System;
use Monolog\Logger;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

/**
 * Class SolrUpdateCommand
 */
class SolrUpdateCommand extends ContainerAwareCommand
{
    /**
     * Configure
     */
    protected function configure()
    {
        $this
            ->setName('casebox:solr:update')
            ->setDescription('Update solr index.')
            ->addOption('all', 'a', InputOption::VALUE_OPTIONAL, 'Reindex all items. Solr will be cleared and all records from tree table will be marked as updated.')
            ->addOption('nolimit', 'l', InputOption::VALUE_OPTIONAL, 'Reindex script indexes, by default, a limited number of items.')
        ;
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     *
     * @return null
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);
        
        $container = $this->getContainer();

        $system = new System();
        $system->bootstrap($container);

        $coreName = $container->getParameter('kernel.environment');
        $all = $input->getOption('all');
        
        $solr = new Client();

        $params = [
            'core' => $coreName,
            'all' => (isset($all)) ? true : null,
            'cron_id' => null,
            'nolimit' => (!empty($input->getOption('nolimit'))) ? $input->getOption('nolimit') : null,
        ];

        $solr->updateTree($params);

        // Log to file
        $log = $container->get('logger');
        $log->pushHandler($container->get('monolog.handler.nested'));
        $log->addInfo('Run casebox:solr:update command.');

        $output->success('command casebox:solr:update');
    }
}
