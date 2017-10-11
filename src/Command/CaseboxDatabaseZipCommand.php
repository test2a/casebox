<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\System;
use Casebox\CoreBundle\Service\Objects;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\DataModel\FilesContent;
use Casebox\CoreBundle\Service\DataModel\Files;
use Casebox\CoreBundle\Service\Plugins\Export\Instance;
use ZipArchive;
use Dompdf\Dompdf;


class CaseboxDatabaseZipCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:database:zip')
            ->setDescription('Perform Zip')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);

        $container = $this->getContainer();

        // Bootstrap
        $system = new System();
        $system->bootstrap($container);
		
		$session = $container->get('session');

        $dbs = Cache::get('casebox_dbs');
		$configService = Cache::get('symfony.container')->get('casebox_core.service.config');
		$user = [
            'id' => 1,
            'name' => 1,
            'first_name' => 1,
            'last_name' => 1,
            'sex' => 1,
            'email' => 1,
            'language_id' => 1,
            'cfg' => 1,
            'data' => 1,
        ];
        
        $session->set('user', $user);
        $zipname = $configService->get('files_dir').DIRECTORY_SEPARATOR.'file.zip';
        echo($zipname);
		$zip = new ZipArchive;
		$zip->open($zipname, ZipArchive::CREATE);
		        
		$clientId = 42630;
		
		$export = new Instance();
		
		$html = $export->getPDFContent($clientId);
		//echo($html);
		
		$dompdf = new Dompdf();
		$dompdf->loadHtml($html);
		$dompdf->setPaper('A4', 'landscape');
		$dompdf->render();
		$recoveryPlan = $dompdf->output();
		
		$zip->addFromString($clientId.'recoveryplan.pdf',$recoveryPlan);		
		
		
		
		$filePlugin = new \Casebox\CoreBundle\Service\Objects\Plugins\Files();
		$files = $filePlugin->getData($clientId);
			
		foreach ($files['data'] as $file) {
			$fileId = $file['id'];
		}		
		
		$r = Files::read($fileId);
		if (!empty($r)) {
            $content = FilesContent::read($r['content_id']);
			$file = $configService->get('files_dir').$content['path'].DIRECTORY_SEPARATOR.$content['id'];
			$zip->addFile($file, $clientId.'consentform.pdf');
		}			
		
		$zip->close();
		
		
		
				
        /*$res = $dbs->query(
            'select * from objects, tree where tree.id = objects.id 
			and tree.template_id = 2265 and data not like \'%"PERSON_ID":""%\''
        );

		$objService = new Objects();
	
        while ($r = $res->fetch()) {
        //29702
        	$content = DM\FilesContent::read($r['content_id']);
			
			$objectId = $r['id'];
			$deleted = $r['dstatus'];
			echo ($objectId.',');

			$obj = $objService->load($r);
			$obj['data']['UPDATE_FIELD'] = 3;
			
			$obj = $objService->save($obj);
			//break;
		}*/
		
        $output->success('command casebox:database:zip');
    }
}
