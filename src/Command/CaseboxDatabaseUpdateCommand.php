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

class CaseboxDatabaseUpdateCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:database:update')
            ->setDescription('Perform Update')
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
		
        $res = $dbs->query(
            'select * from tree where template_id in(1205,1976) and pid = 41491'
        );
        /*
                $res = $dbs->query(
            'select * from objects, tree where tree.id = objects.id 
			and tree.template_id = 2265 and objects.id > 25785 and data not like \'%"PERSON_ID":""%\'
			order by objects.id desc'
        );
        */

		$objService = new Objects();
	
        while ($r = $res->fetch()) {
			$objectId = $r['id'];
			$deleted = $r['dstatus'];
			echo ($objectId.',');

			$obj = $objService->load($r);
			echo ($obj['data']['data']['area']);
			$sqql = 
			$locs = $dbs->query(
				'select
					substring(data, LOCATE(\'"_locationcounty":\', data)+19, 
					LOCATE(\'"\',data,LOCATE(\'"_locationcounty":\', data)+19)-
					(LOCATE(\'"_locationcounty":\', data)+19)) locationcounty,
					substring(data, LOCATE(\'"_locationregion":\', data)+19, 
					LOCATE(\'"\',data,LOCATE(\'"_locationregion":\', data)+19)-
					(LOCATE(\'"_locationregion":\', data)+19)) locationregion,
					objects.id,name
					from objects,tree where tree.id = objects.id
					and tree.template_id = 3269
					and dstatus = 0
					and name = \''.$obj['data']['data']['area'].'\'
					order by locationregion, name'
			);
			if ($rz = $locs->fetch()) {
						echo ($obj['data']['data']['area']);
				$id = $rz['id'];
				$obj['data']['data']['area'] = $rz['locationregion'].'-'.$rz['name'];
				$obj = $objService->save($obj);
			}

			//break;
		}
		
        $output->success('command casebox:database:update');
    }
}
