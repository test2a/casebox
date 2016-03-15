<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\PreviewExtractor;
use Casebox\CoreBundle\Service\Solr\Client;
use Casebox\CoreBundle\Service\System;
use Monolog\Logger;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Class PreviewExtractorCommand
 */
class PreviewExtractorCommand extends ContainerAwareCommand
{
    /**
     * Configure
     */
    protected function configure()
    {
        $this
            ->setName('casebox:preview:extract')
            ->setDescription('Document preview extractor.')
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
        $container = $this->getContainer();

        $system = new System();
        $system->bootstrap($container);

        // Functionality
        $extractor = new PreviewExtractor();
        $extractor->execute();

        // Log to file
        $log = $container->get('logger');
        $log->pushHandler($container->get('monolog.handler.nested'));
        $log->addInfo('Run casebox:preview:extract command.');

        $output->writeln('DONE!');
    }
}
