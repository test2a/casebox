<?php

namespace Casebox\CoreBundle\Command;

use Casebox\CoreBundle\Service\System;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Casebox\CoreBundle\Service\Cache;

class CaseboxUserGroupsResetCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:user:reset')
            ->setDescription('Force reset of users passwords based on days.')
            ->addArgument('days', InputArgument::REQUIRED, 'The days since last password change to reset force reset')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);

        $container = $this->getContainer();
        $system = new System();
        $system->bootstrap($container);

        $days = intval($input->getArgument('days'));

		if ($days == 0)
		{
			$days = 45;
		}
		
		
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

		$session->set('verified',true);
        $session->set('user', $user);
		
		$res = $dbs->query(
			'SELECT
				u.id
			FROM users_groups u
			WHERE u.type = 2 
		    and u.system = 0
			and u.enabled = 1
			and IFNULL(u.password_change, from_unixtime(u.cdate)) < DATE_SUB(NOW(), INTERVAL $1 DAY)
	  ',
				 $days
        );

		
		while ($r = $res->fetch()) {
/*			$p = [
				'id' => $r['id'],
				'enabled' => false
			];*/
			$rez = $container->get('casebox_core.service.users_groups')->sendResetPasswordMail($r['id'], 'recover');
		}
		unset($res);
		
        $output->success('command casebox:user:reset');
    }
}
