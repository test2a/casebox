<?php

namespace Casebox\CoreBundle\Service\Plugins\Export;

use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\BrowserView;
use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Objects\Plugins\ContentItems;
use Symfony\Component\DependencyInjection\Container;
use Dompdf\Dompdf;

class Instance
{
    public function install()
    {

    }

    public function init()
    {
    }

    protected function getData($p)
    {
        $rez = [];
        if (empty($p)) {
            return $rez;
        }

        $configService = Cache::get('symfony.container')->get('casebox_core.service.config');
        // form columns
        $defaultColumns = $configService->getDefaultGridColumnConfigs();
        $columns = $defaultColumns;

        // retreive data
        $p['start'] = 0;
        $p['rows'] = 500;

        $sr = new BrowserView();
        $results = $sr->getChildren($p);

        if (!empty($results['DC'])) {
            $columns = [];

            foreach ($results['DC'] as $colName => $col) {
                if (@$col['hidden'] !== true) {
                    $columns[$colName] = $col;
                }
            }
        }

        $colTitles = [];
        foreach ($columns as $name => $col) {
            $colTitles[] = empty($defaultColumns[$name]) ? @Util\coalesce($col['title'], $name) : $defaultColumns[$name]['title'];
        }

        //insert header
        $rez[] = $colTitles;

        while (!empty($results['data'])) {
            foreach ($results['data'] as $r) {
                $record = [];
                foreach ($columns as $colName => $col) {

                    if (@$col['xtype'] == 'datecolumn') {
                        $value = Util\dateISOToMysql(@$r[$colName]);

                        if (!empty($col['format'])) {
                            $value = Util\formatMysqlTime($value, $col['format']);

                        } else {
                            $value = Util\formatMysqlTime($value);
                            $tmp = explode(' ', $value);
                            if (!empty($tmp[1]) && ($tmp[1] == '00:00')) {
                                $value = $tmp[0];
                            }
                        }
                        $record[] = $value;

                    } elseif (strpos($colName, 'date') === false) {
                        if (in_array($colName, ['oid', 'cid', 'uid']) && !empty($r[$colName])) {
                            $record[] = User::getDisplayName($r[$colName]);
                        } else {
                            $record[] = @$r[$colName];
                        }
                    }

                }
                $rez[] = $record;
            }

            if (($p['start'] + $p['rows']) < $results['total']) {
                $p['start'] += $p['rows'];
                $results = $sr->getChildren($p);
            } else {
                $results['data'] = [];
            }
        }

        return $rez;
    }

    /**
     * get csv file
     *
     * @param $p object
     */
    public function getCSV($p)
    {
        $rez = [];
        $records = $this->getData($p);

        $rez[] = implode(',', array_shift($records));

        foreach ($records as &$r) {
            $record = [];
            foreach ($r as $t) {
                $t = strip_tags($t);

                if (!empty($t) && !is_numeric($t)) {
                    $t = str_replace(
                        [
                            '"',
                            "\n",
                            "\r",
                        ],
                        [
                            '""',
                            '\n',
                            '\r',
                        ],
                        $t
                    );
                    $t = '"'.$t.'"';
                }
                $record[] = $t;
            }

            $rez[] = implode(',', $record);
        }
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=Exported_Results_'.date('Y-m-d_Hi').'.csv');
        header("Pragma: no-cache");
        header("Expires: 0");
        echo implode("\n", $rez);
    }
	
	public function getPDF($p)
	{
        // Check if object id is numeric
        if (!is_numeric($p)) {
            throw new \Exception($this->trans('Wrong_input_data'));
        }
		
		$container = Cache::get('symfony.container');
		$twig = $container->get('twig');
		$configService = Cache::get('symfony.container')->get('casebox_core.service.config');		
		
		$objService = new Objects();
		$obj = $objService->load(['id' => $p]);
		//print_r($obj['data']['data']['sys_data']);
		
		$contentItems = new ContentItems();
		$items = $contentItems->getData($p);
		$femaNumber = 'N/A';
		
		
		
		 foreach ($items['data'] as $item) {
                if ($item['template_id'] == 607)
				{
					 $comments = '';
					 $service = $objService->load($item);
					 $referralType = Objects::getCachedObject($service['data']['data']['_referraltype']['value']);	
					 $refferalTypeValue = empty($referralType) ? 'N/A' : $referralType->getHtmlSafeName();
					 $referralSubType = Objects::getCachedObject($service['data']['data']['_referraltype']['childs']['_referralservice']);						 
					 $refferalSubTypeValue = empty($referralSubType) ? 'N/A' : $referralSubType->getHtmlSafeName();
					 if (!empty($service['data']['data']['_provider']))
					 {
					 	$resource = $objService->load(['id' => $service['data']['data']['_provider']]);	
					 }				
					 else
					 {
					 	unset($resource);
					 }	 
					 //$resourceValue = empty($resource) ? 'N/A' : $resource->getHtmlSafeName();
					 //print_r($service);
					 	foreach ($service['data']['data']['_commentgroup'] as $key) {
   							 $comments = $comments. $key['childs']['_comments'] . ' ('.Util\formatMysqlDate($key['childs']['_commentdate'], Util\getOption('short_date_format')).'),';
						}
						$comments = trim($comments,',') .$service['data']['data']['_commentgroup']['childs']['_comments']. ' ('.Util\formatMysqlDate($service['data']['data']['_commentgroup']['childs']['_commentdate'], Util\getOption('short_date_format')).'),';
					 	
				     $services[] = [
						'associatedneed' => $service['data']['data']['_associatedneed'],
						'associatedgoal' => $service['data']['data']['_associatedgoal'],			
						'referraltype' => $refferalTypeValue,
						'referralsubtype' => $refferalSubTypeValue,
						'resourceagencyname' => empty($resource) ? 'N/A' : $resource['data']['data']['_providername'],
						'resourceagencycontactinformation' => empty($resource) ? 'N/A' : $resource['data']['data']['_streetaddress']. ' ' .$resource['data']['data']['_city']. ' ' .$resource['data']['data']['_state']. ' ' .$resource['data']['data']['_zipcode']. ' ' .$resource['data']['data']['phonenumbers'],
						'pointofcontact' => empty($resource) ? 'N/A' : $resource['data']['data']['_pointofcontact'],
						'referralappointmentdatetime' =>Util\formatMysqlDate($service['data']['data']['_appointmentdate'], Util\getOption('short_date_format')). ' ' . $service['data']['data']['_appointmenttime'],
						'targetcompletiondate' =>  Util\formatMysqlDate($service['data']['data']['_targetcompletiondate'], Util\getOption('short_date_format')),
						'comments' => str_replace('()','',trim($comments,','))
					];	
				} else if ($item['template_id'] == 1120)
				{
					$femaassessment = $objService->load($item);
					if (!empty($femaassessment['data']['data']['_clienthavefemanumber']['childs']['_femanumber']))
					{
						$femaNumber = $femaassessment['data']['data']['_clienthavefemanumber']['childs']['_femanumber'];
					}
				}
            }
		$v = $obj['data']['data']['assigned'];
		
		if (empty($v)) {
			$assigned = 'N/A';
		}else 
		{
             $assigned = User::getDisplayName($v);
			 //echo(User::getUserData($v)['phone']);
		}
		
		$vars = [
			'client_lastname' => $obj['data']['data']['_lastname'],
			'client_firstname' => $obj['data']['data']['_firstname'],			
            'disaster_declaration_number' => $configService->get('disaster_declaration_number'),
			'disaster_site_address' => $configService->get('disaster_site_address'),
			'cm_phone' => $configService->get('disaster_phone_number'),
            'cm_assigned' => $assigned,
            'cm_phone' =>$configService->get('disaster_phone_number'),
            'plan_creation_date' => date("F j, Y, g:i a"),
            'fema_registration_number' => $femaNumber,
            'client_id' => $obj['data']['id'],
			'services' =>
				$services,
        ];
		$html = $twig->render('CaseboxCoreBundle:email:recovery-plan.html.twig', $vars);
		//echo ($html);
		//return;
		// instantiate and use the dompdf class
		$dompdf = new Dompdf();
		$dompdf->loadHtml($html);

		// (Optional) Setup the paper size and orientation
		$dompdf->setPaper('A4', 'landscape');

		// Render the HTML as PDF
		$dompdf->render();
		$dompdf->stream('recovery_plan'.$p, array("Attachment" => false));

		exit(0);
        /*header('Content-Type: application/pdf; charset=utf-8');
        header('Content-Disposition: inline; filename=OUT_'.date('Y-m-d_Hi').'.pdf');
        header("Pragma: no-cache");
        header("Expires: 0");*/
		// Output the generated PDF to Browser
		$dompdf->stream();

	}

    public function getHTML($p)
    {
        $rez = [];
        $records = $this->getData($p);

        $rez[] = '<th>'.implode('</th><th>', array_shift($records)).'</th>';

        foreach ($records as $r) {
            $record = [];
            foreach ($r as $t) {
                $t = strip_tags($t);
                $record[] = $t;
            }
            $rez[] = '<td>'.implode('</td><td>', $record).'</td>';
        }

        header('Content-Type: text/html; charset=utf-8');
        header('Content-Disposition: attachment; filename=Exported_Results_'.date('Y-m-d_Hi').'.html');
        header("Pragma: no-cache");
        header("Expires: 0");
        echo '<!DOCTYPE html>
            <html>
            <header>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" >
            </header>
            <body>
            <table border="1" style="border-collapse: collapse">
            <tr>';
        echo implode("</tr>\n<tr>", $rez);
        echo '</tr></table></body></html>';
    }
}
<?php

namespace Casebox\CoreBundle\Service\Plugins\Export;

use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\BrowserView;
use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Objects\Plugins\ContentItems;
use Symfony\Component\DependencyInjection\Container;
use Dompdf\Dompdf;

class Instance
{
    public function install()
    {

    }

    public function init()
    {
    }

    protected function getData($p)
    {
        $rez = [];
        if (empty($p)) {
            return $rez;
        }

        $configService = Cache::get('symfony.container')->get('casebox_core.service.config');
        // form columns
        $defaultColumns = $configService->getDefaultGridColumnConfigs();
        $columns = $defaultColumns;

        // retreive data
        $p['start'] = 0;
        $p['rows'] = 500;

        $sr = new BrowserView();
        $results = $sr->getChildren($p);

        if (!empty($results['DC'])) {
            $columns = [];

            foreach ($results['DC'] as $colName => $col) {
                if (@$col['hidden'] !== true) {
                    $columns[$colName] = $col;
                }
            }
        }

        $colTitles = [];
        foreach ($columns as $name => $col) {
            $colTitles[] = empty($defaultColumns[$name]) ? @Util\coalesce($col['title'], $name) : $defaultColumns[$name]['title'];
        }

        //insert header
        $rez[] = $colTitles;

        while (!empty($results['data'])) {
            foreach ($results['data'] as $r) {
                $record = [];
                foreach ($columns as $colName => $col) {

                    if (@$col['xtype'] == 'datecolumn') {
                        $value = Util\dateISOToMysql(@$r[$colName]);

                        if (!empty($col['format'])) {
                            $value = Util\formatMysqlTime($value, $col['format']);

                        } else {
                            $value = Util\formatMysqlTime($value);
                            $tmp = explode(' ', $value);
                            if (!empty($tmp[1]) && ($tmp[1] == '00:00')) {
                                $value = $tmp[0];
                            }
                        }
                        $record[] = $value;

                    } elseif (strpos($colName, 'date') === false) {
                        if (in_array($colName, ['oid', 'cid', 'uid']) && !empty($r[$colName])) {
                            $record[] = User::getDisplayName($r[$colName]);
                        } else {
                            $record[] = @$r[$colName];
                        }
                    }

                }
                $rez[] = $record;
            }

            if (($p['start'] + $p['rows']) < $results['total']) {
                $p['start'] += $p['rows'];
                $results = $sr->getChildren($p);
            } else {
                $results['data'] = [];
            }
        }

        return $rez;
    }

    /**
     * get csv file
     *
     * @param $p object
     */
    public function getCSV($p)
    {
        $rez = [];
        $records = $this->getData($p);

        $rez[] = implode(',', array_shift($records));

        foreach ($records as &$r) {
            $record = [];
            foreach ($r as $t) {
                $t = strip_tags($t);

                if (!empty($t) && !is_numeric($t)) {
                    $t = str_replace(
                        [
                            '"',
                            "\n",
                            "\r",
                        ],
                        [
                            '""',
                            '\n',
                            '\r',
                        ],
                        $t
                    );
                    $t = '"'.$t.'"';
                }
                $record[] = $t;
            }

            $rez[] = implode(',', $record);
        }
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=Exported_Results_'.date('Y-m-d_Hi').'.csv');
        header("Pragma: no-cache");
        header("Expires: 0");
        echo implode("\n", $rez);
    }
	
	public function getPDF($p)
	{
        // Check if object id is numeric
        if (!is_numeric($p)) {
            throw new \Exception($this->trans('Wrong_input_data'));
        }
		
		$container = Cache::get('symfony.container');
		$twig = $container->get('twig');
		$configService = Cache::get('symfony.container')->get('casebox_core.service.config');		
		
		$objService = new Objects();
		$obj = $objService->load(['id' => $p]);
		//print_r($obj['data']['data']['sys_data']);
		
		$contentItems = new ContentItems();
		$items = $contentItems->getData($p);
		$femaNumber = 'N/A';
		
		
		
		 foreach ($items['data'] as $item) {
                if ($item['template_id'] == 607)
				{
					 $comments = '';
					 $service = $objService->load($item);
					 $referralType = Objects::getCachedObject($service['data']['data']['_referraltype']['value']);	
					 $refferalTypeValue = empty($referralType) ? 'N/A' : $referralType->getHtmlSafeName();
					 $referralSubType = Objects::getCachedObject($service['data']['data']['_referraltype']['childs']['_referralservice']);						 
					 $refferalSubTypeValue = empty($referralSubType) ? 'N/A' : $referralSubType->getHtmlSafeName();
					 if (!empty($service['data']['data']['_provider']))
					 {
					 	$resource = $objService->load(['id' => $service['data']['data']['_provider']]);	
					 }				
					 else
					 {
					 	unset($resource);
					 }	 
					 //$resourceValue = empty($resource) ? 'N/A' : $resource->getHtmlSafeName();
					 //print_r($service);
					 	foreach ($service['data']['data']['_commentgroup'] as $key) {
   							 $comments = $comments. $key['childs']['_comments'] . ' ('.Util\formatMysqlDate($key['childs']['_commentdate'], Util\getOption('short_date_format')).'),';
						}
						$comments = trim($comments,',') .$service['data']['data']['_commentgroup']['childs']['_comments']. ' ('.Util\formatMysqlDate($service['data']['data']['_commentgroup']['childs']['_commentdate'], Util\getOption('short_date_format')).'),';
					 	
				     $services[] = [
						'associatedneed' => $service['data']['data']['_associatedneed'],
						'associatedgoal' => $service['data']['data']['_associatedgoal'],			
						'referraltype' => $refferalTypeValue,
						'referralsubtype' => $refferalSubTypeValue,
						'resourceagencyname' => empty($resource) ? 'N/A' : $resource['data']['data']['_providername'],
						'resourceagencycontactinformation' => empty($resource) ? 'N/A' : $resource['data']['data']['_streetaddress']. ' ' .$resource['data']['data']['_city']. ' ' .$resource['data']['data']['_state']. ' ' .$resource['data']['data']['_zipcode']. ' ' .$resource['data']['data']['phonenumbers'],
						'pointofcontact' => empty($resource) ? 'N/A' : $resource['data']['data']['_pointofcontact'],
						'referralappointmentdatetime' =>Util\formatMysqlDate($service['data']['data']['_appointmentdate'], Util\getOption('short_date_format')). ' ' . $service['data']['data']['_appointmenttime'],
						'targetcompletiondate' =>  Util\formatMysqlDate($service['data']['data']['_targetcompletiondate'], Util\getOption('short_date_format')),
						'comments' => str_replace('()','',trim($comments,','))
					];	
				} else if ($item['template_id'] == 1120)
				{
					$femaassessment = $objService->load($item);
					if (!empty($femaassessment['data']['data']['_clienthavefemanumber']['childs']['_femanumber']))
					{
						$femaNumber = $femaassessment['data']['data']['_clienthavefemanumber']['childs']['_femanumber'];
					}
				}
            }
		$v = $obj['data']['data']['assigned'];
		
		if (empty($v)) {
			$assigned = 'N/A';
		}else 
		{
             $assigned = User::getDisplayName($v);
			 //echo(User::getUserData($v)['phone']);
		}
		
		$vars = [
			'client_lastname' => $obj['data']['data']['_lastname'],
			'client_firstname' => $obj['data']['data']['_firstname'],			
            'disaster_declaration_number' => $configService->get('disaster_declaration_number'),
			'disaster_site_address' => $configService->get('disaster_site_address'),
			'cm_phone' => $configService->get('disaster_phone_number'),
            'cm_assigned' => $assigned,
            'cm_phone' =>$configService->get('disaster_phone_number'),
            'plan_creation_date' => date("F j, Y, g:i a"),
            'fema_registration_number' => $femaNumber,
            'client_id' => $obj['data']['id'],
			'services' =>
				$services,
        ];
		$html = $twig->render('CaseboxCoreBundle:email:recovery-plan.html.twig', $vars);
		//echo ($html);
		//return;
		// instantiate and use the dompdf class
		$dompdf = new Dompdf();
		$dompdf->loadHtml($html);

		// (Optional) Setup the paper size and orientation
		$dompdf->setPaper('A4', 'landscape');

		// Render the HTML as PDF
		$dompdf->render();
		$dompdf->stream('recovery_plan'.$p, array("Attachment" => false));

		exit(0);
        /*header('Content-Type: application/pdf; charset=utf-8');
        header('Content-Disposition: inline; filename=OUT_'.date('Y-m-d_Hi').'.pdf');
        header("Pragma: no-cache");
        header("Expires: 0");*/
		// Output the generated PDF to Browser
		$dompdf->stream();

	}

    public function getHTML($p)
    {
        $rez = [];
        $records = $this->getData($p);

        $rez[] = '<th>'.implode('</th><th>', array_shift($records)).'</th>';

        foreach ($records as $r) {
            $record = [];
            foreach ($r as $t) {
                $t = strip_tags($t);
                $record[] = $t;
            }
            $rez[] = '<td>'.implode('</td><td>', $record).'</td>';
        }

        header('Content-Type: text/html; charset=utf-8');
        header('Content-Disposition: attachment; filename=Exported_Results_'.date('Y-m-d_Hi').'.html');
        header("Pragma: no-cache");
        header("Expires: 0");
        echo '<!DOCTYPE html>
            <html>
            <header>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" >
            </header>
            <body>
            <table border="1" style="border-collapse: collapse">
            <tr>';
        echo implode("</tr>\n<tr>", $rez);
        echo '</tr></table></body></html>';
    }
}
