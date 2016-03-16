<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\System;
use Guzzle\Http\Client;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Class SolrCreateCommand
 */
class SolrCreateCommand extends ContainerAwareCommand
{
    /**
     * Configure
     */
    protected function configure()
    {
        $this
            ->setName('casebox:solr:create')
            ->setDescription('Create solr index.');
    }

    /**
     * @param InputInterface $input
     * @param OutputInterface $output
     *
     * @return null
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $system = new System();
        $system->bootstrap($this->getContainer());
        $params = Cache::get('platformConfig');

        $solrSchema = $params['solr_schema'];
        $solrHost = $params['solr_host'];
        $solrPort = $params['solr_port'];
        $solrUsername = $params['solr_username'];
        $solrPassword = $params['solr_password'];

        $client = new Client();

        $solrCores = [
            $params['solr_core'] => 'casebox',
            $params['solr_core_log'] => 'casebox_log',
        ];

        foreach ($solrCores as $solrCore => $configSet) {
            $options = [
                'query' => [
                    'action' => 'CREATE',
                    'name' => $solrCore,
                    'configSet' => $configSet,
                    'wt' => 'json',
                ],
            ];

            if (!empty($solrUsername) && !empty($solrPassword)) {
                $options['auth'] = [
                    $solrUsername,
                    $solrPassword,
                    'Basic',
                ];
            }

            $req = $client->get(
                ltrim($solrSchema, '//').'://'.$solrHost.':'.$solrPort.'/solr/admin/cores',
                [],
                $options
            );
            $result = $req->send();

            $statusCode = $result->getStatusCode();
            if ($statusCode == 200) {
                $output->writeln('<info>'.sprintf("Success. Created '%s' core.", $solrCore).'</info>');
            } else {
                $output->writeln('<error>'.sprintf("Error. Unable to created '%s' core.", $solrCore).'</error>');
            }
        }

        $output->writeln('DONE!');
    }
}
