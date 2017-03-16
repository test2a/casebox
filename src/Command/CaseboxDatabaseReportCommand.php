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

class CaseboxDatabaseReportCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('casebox:database:report')
            ->setDescription('Create Report')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output = new SymfonyStyle($input, $output);

        $container = $this->getContainer();

        // Bootstrap
        $system = new System();
        $system->bootstrap($container);

		//$user = $container->get('doctrine.orm.entity_manager')->getRepository('CaseboxCoreBundle:UsersGroups')->findUserByUsername('root');
		
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
            'select  
			SUM(IF (DATE(tree.udate) = CURDATE() OR DATE(tree.cdate) = CURDATE(),1,0)) total_client_contact, 
			SUM(IF (DATE(tree.cdate) = CURDATE(),1,0)) new_open_cases,
			SUM(IF (sys_data like \'%"assessments_completed":[]%\' and sys_data like \'%"case_status":"Active"%\',1,0) ) client_intake,
			SUM(IF (sys_data like \'%"case_status":"Information Only"%\',1,0) ) information_only,
			SUM(IF (sys_data not like \'%"assessments_completed":[]%\' and sys_data like \'%"case_status":"Active"%\',1,0) ) assessments_total,
			SUM(IF (sys_data like \'%"case_status":"Closed"%\'and sys_data like \'%"closurereason_s":"Goals achieved"%\',1,0) ) closed_records_recovery_plan_complete,
			SUM(IF (sys_data like \'%"case_status":"Closed"%\'and sys_data not like \'%"closurereason_s":"Goals achieved"%\',1,0) ) closed_records_recovery_plan_not_complete,
			(select count(*) from tree where template_id =607 and dstatus = 0) referrals_total,
			SUM(IF (data like \'%"_addresstype":323%\' AND (DATE(tree.udate) = CURDATE() OR DATE(tree.cdate) = CURDATE())    ,1,0) ) temporary_housing,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 1,1) top_client_need,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 2,1) second_client_need,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 3,1) third_client_need,
			SUM(IF (sys_data like \'%"fematier":"Tier 1%\',1,0) ) fema_tier_1,
			SUM(IF (sys_data like \'%"fematier":"Tier 2%\',1,0) ) fema_tier_2,
			SUM(IF (sys_data like \'%"fematier":"Tier 3%\',1,0) ) fema_tier_3,
			SUM(IF (sys_data like \'%"fematier":"Tier 4%\',1,0) ) fema_tier_4,
			case_managers.total case_mamager_total,
			case_manager_supervisors.total case_manager_supervisor_total,
			case_manager_supervisors.total/case_managers.total as case_manager_to_supervisor_ratio,
			count(*)/case_managers.total as case_manager_to_client_ratio
			from objects, 
			tree,
			(select 141 template_id, count(*) total from users_groups 
			where users_groups.id in 
			(select user_id from users_groups_association where group_id = 
			(select id from users_groups where replace(users_groups.name,\'Managers\',\'Manager\') = \'Case Manager\'))) case_managers,
			(select 141 template_id, count(*) total from users_groups 
			where users_groups.id in 
			(select user_id from users_groups_association where group_id = 
			(select id from users_groups 
			where replace(replace(users_groups.name,\'Managers\',\'Manager\'), \'Supervisors\',\'Supervisor\') = \'Case Manager Supervisor\'))) case_manager_supervisors
			where 
			tree.template_id = 141
			and
			objects.id = tree.id
			and 
			tree.dstatus = 0
			group by tree.template_id'
        );

        if ($r = $res->fetch()) {
			$r['report_date']=date('Y-m-d', time()).'T00:00:00Z';
			$data = [
				'pid' => 1204,
				'title' => 'New FEMA Report',
				'template_id' => 1205,
				'path' => '/Test Event/Reports/',
				'view' => 'edit',
				'name' => 'New FEMA Daily Report',
				'data' => $r,
			];
			
			$objService = new Objects();
			$newReferral =$objService->create($data);		
		
		}
		
		

        $res = $dbs->query(
            'select  
			COUNT(*) client_fema_registrations, 
			SUM(IF (substring(sys_data, LOCATE(\'identified_unmet_needs_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'identified_unmet_needs_ss\', sys_data))-LOCATE(\'identified_unmet_needs_ss\', sys_data) ) like \'%FEMA%\',1,0)) fema_help,
			SUM(IF (substring(sys_data, LOCATE(\'referralservice_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'referralservice_ss\', sys_data))-LOCATE(\'referralservice_ss\', sys_data) ) like \'%SBA%\',1,0)) sba_help,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'% Disabilities %\',1,0)) self_reported_disabilities,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'% English %\',1,0)) self_reported_limited_english,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'%Children%\',1,0)) self_reported_children,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'%Elderly%\',1,0)) self_reported_elderly,
			SUM(IF (data like \'%"_gender":214%\' and data like \'%_headofhousehold":347%\',1,0) ) male_hoh,
			SUM(IF (data like \'%"_gender":215%\' and data like \'%_headofhousehold":347%\',1,0) ) female_hoh,
			SUM(IF (data not like \'%"_gender":215%\' and data not like \'%"_gender":214%\' and data like \'%_headofhousehold":347%\',1,0) ) other_hoh,
			SUM(IF (data like \'%"_gender":214%\' and data not like \'%_headofhousehold":347%\',1,0) ) male_not_hoh,
			SUM(IF (data like \'%"_gender":215%\' and data not like \'%_headofhousehold":347%\',1,0) ) female_not_hoh,
			SUM(IF (data not like \'%"_gender":215%\' and data not like \'%"_gender":214%\' and data not like \'%_headofhousehold":347%\',1,0) ) other_not_hoh,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'%Children%\' and data like \'%"_gender":214%\' and data like \'%"_maritalstatus":1037%\' and data like \'%_headofhousehold":347%\',1,0) ) single_male_hoh_under_18,
			SUM(IF (substring(sys_data, LOCATE(\'at_risk_population_ss\', sys_data), LOCATE(\']\',sys_data,LOCATE(\'at_risk_population_ss\', sys_data))-LOCATE(\'at_risk_population_ss\', sys_data) ) like \'%Children%\' and data like \'%"_gender":215%\' and data like \'%"_maritalstatus":1037%\' and data like \'%_headofhousehold":347%\',1,0) ) single_female_hoh_under_18,
			SUM(IF (data like \'%"_race":238%\',1,0) ) race_white,
			SUM(IF (data like \'%"_race":236%\',1,0) ) race_black,
			SUM(IF (data like \'%"_race":234%\',1,0) ) race_american_indian,
			SUM(IF (data like \'%"_race":235%\',1,0) ) race_asian,
			SUM(IF (data like \'%"_race":235%\',1,0) ) race_chinese,
			SUM(IF (data like \'%"_race":1138%\',1,0) ) race_filipino,
			SUM(IF (data like \'%"_race":1144%\',1,0) ) race_guamanian,
			SUM(IF (data like \'%"_race":1140%\',1,0) ) race_japanese,
			SUM(IF (data like \'%"_race":1141%\',1,0) ) race_korean,
			SUM(IF (data like \'%"_race":1143%\',1,0) ) race_hawaiian,
			SUM(IF (data like \'%"_race":1146%\',1,0) ) race_other_pacific,
			SUM(IF (data like \'%"_race":1145%\',1,0) ) race_samoan,
			SUM(IF (data like \'%"_race":1142%\',1,0) ) race_vietnamese,
			SUM(IF (data like \'%"_race":240%\',1,0) ) race_refused,
			SUM(IF (data not like \'%"_race"%\',1,0) ) race_not_collected,
			SUM(IF (sys_data like \'%"housingclientdamagerating_s":"Major"%\',1,0) ) home_damage_major,
			SUM(IF (sys_data like \'%"housingclientdamagerating_s":"Minor"%\',1,0) ) home_damage_minor,
			SUM(IF (sys_data like \'%"housingclientdamagerating_s":"Destroyed"%\',1,0) ) home_damage_destroyed,
			SUM(IF (sys_data like \'%"housingclientdamagerating_s":"Client%\',1,0) ) home_damage_unknown,
			SUM(IF (sys_data like \'%(TSA)%\',1,0) ) home_enrolled_in_tsa,
			SUM(IF (sys_data like \'%homeowner\'\'s insurance%\',1,0) ) home_homeowners_insurance,
			SUM(IF (sys_data like \'%hazard-specific insurance%\',1,0) ) home_hazard_insurance,
			SUM(IF (sys_data like \'%Lack of appropriate Insurance Coverage%\',1,0) ) home_lackof_insurance,
			SUM(IF (sys_data like \'%Client does not know insurance status%\',1,0) ) home_doesntknow_insurance,
			SUM(IF (sys_data like \'%Client was insured but does not have insurance policy information%\',1,0) ) home_doesnthave_insurance,
			SUM(IF (sys_data like \'%Client was uninsured%\',1,0) ) home_uninsured,
			AVG(IF (sys_data like \'%financialannualincometotal_i%\',substring(sys_data, LOCATE(\'financialannualincometotal_i\',sys_data)+30,LOCATE(\',\', substring(sys_data, LOCATE(\'financialannualincometotal_i\',sys_data)+31))),0)) financial_income_level,
			AVG(IF (sys_data like \'%financialpercentageoffederalpoverylevel_f%\',substring(sys_data, LOCATE(\'financialpercentageoffederalpoverylevel_f\',sys_data)+43,LOCATE(\',\', substring(sys_data, LOCATE(\'financialpercentageoffederalpoverylevel_f\',sys_data)+44))),0)) financial_federal_poverty_level,
			SUM(IF (sys_data like \'%"employmentreferralneeded_s":"Yes"%\',1,0) ) employment_referral_needed,
			SUM(IF (sys_data like \'%"healthinsurancelostdisaster_s":"Yes"%\',1,0) ) insurance_lost_to_disaster,
			SUM(IF (sys_data like \'%"healthhavehealthinsurance_s":"Yes"%\',1,0) ) insurance_have_insurance,
			SUM(IF (sys_data like \'%"healthinsurancetype_s":"S-Chip%"%\',1,0) ) insurance_s_chip,
			SUM(IF (sys_data like \'%"transportationreferralneeded_s":"Yes"%\',1,0) ) transportation_referral_needed,
			SUM(IF (sys_data like \'%Childcare%\' AND sys_data like \'%"childassesmentreferralservice_s"%\',1,0) ) child_care_referral_needed,
			SUM(IF (sys_data like \'%"childassesmentfosterchildren_s":"Yes"%\',1,0) ) child_fostercare,
			SUM(IF (sys_data like \'%Head Start%\' AND sys_data like \'%"childassesmentreferralservice_s"%\',1,0) ) child_headstart_referral_needed,
			SUM(IF (sys_data like \'%child support%\' AND sys_data like \'%"childassesmentreferralservice_s"%\',1,0) ) child_support_referral_needed,
			SUM(IF ((sys_data like \'%School District%\' OR sys_data like \'%school supplies%\') AND sys_data like \'%"childassesmentreferralservice_s"%\',1,0) ) child_education_support_needed,
			SUM(IF (sys_data like \'%"foodreferralneeded_s":"Yes"%\',1,0) ) food_referral_needed,
			SUM(IF (sys_data like \'%D-SNAP%\',1,0) ) dsnap_referral_needed,
			SUM(IF (sys_data like \'%"clothingreferralneeded_s":"Yes"%\',1,0) ) clothing_referral_needed,
			SUM(IF (sys_data like \'%"furnitureandappliancesreferralneeded_s":"Yes"%\',1,0) ) furniture_referral_needed,
			SUM(IF (sys_data like \'%"seniorservicesreferralneeded_s":"Yes"%\',1,0) ) senior_referral_needed,
			SUM(IF (sys_data like \'%"languagereferralneeded_s":"Yes"%\',1,0) ) language_referral_needed,
			SUM(IF (sys_data like \'%"legalservicesreferralneeded_s":"Yes"%\',1,0) ) legal_referral_needed,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 1,1) top_client_need,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 2,1) second_client_need,
			(SELECT REPLACE(templates.name,\'Assessment\',\'\') FROM   objects, tree, templates where objects.id = tree.id and tree.template_id = templates.id and templates.name like \'%Assessment\' 
			group by templates.name
			limit 3,1) third_client_need,
			SUM(IF (sys_data like \'%"fematier":"Tier 1%\',1,0) ) fema_tier_1,
			SUM(IF (sys_data like \'%"fematier":"Tier 2%\',1,0) ) fema_tier_2,
			SUM(IF (sys_data like \'%"fematier":"Tier 3%\',1,0) ) fema_tier_3,
			SUM(IF (sys_data like \'%"fematier":"Tier 4%\',1,0) ) fema_tier_4
			from objects, 
			tree
			where 
			tree.template_id = 141
			and
			objects.id = tree.id
			and 
			tree.dstatus = 0
			group by tree.template_id'
        );

        if ($r = $res->fetch()) {
			$r['report_date']=date('Y-m-d', time()).'T00:00:00Z';
			$data = [
				'pid' => 1204,
				'title' => 'New OHSEPR Daily Report',
				'template_id' => 1976,
				'path' => '/Test Event/Reports/',
				'view' => 'edit',
				'name' => 'New OHSEPR Daily Report',
				'data' => $r,
			];
		
			$objService = new Objects();
			$newReferral =$objService->create($data);
        }		
		
        $output->success('command casebox:database:report');
    }
}
