<?php

namespace Casebox\CoreBundle\Service\Objects;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Solr\Client;
use Casebox\CoreBundle\Service\DataModel as DM;

/**
 * Template class
 */
class CaseAssessment extends Object
{
	public function create($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
		
		$this->data = $p;
		$this->setParamsFromData($p);
        
		return parent::create($p);
    }
	
    public function update($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
		$this->data = $p;
        $this->setParamsFromData($p);

        return parent::update($p);
    }
	
    public function deleteCustomData($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
        $this->setParamsFromDelete($p);
		
        return parent::deleteCustomData($p);

	}

    protected function setParamsFromData(&$p)
    {
		$caseId = $p['pid'];
		$templateId = $p['template_id'];
		$objectId = $p['id'];
        
		if ($caseId) {
            $case = Objects::getCachedObject($caseId);    
			$caseData = &$case->data;
			$caseSd = &$caseData['sys_data'];

			
			
			/* add some values to the parent */
			$tpl = $this->getTemplate();

			if (!empty($tpl)) {
				$fields = $tpl->getFields();
				
				foreach ($fields as $f) {
					$values = $this->getFieldValue($f['name']);
					if (!empty($f['solr_column_name'])) {	
						$sfn = $f['solr_column_name']; // Solr field name
						unset($caseSd[$sfn]);
						if ($values != null) {
							if (substr($f['solr_column_name'], -2) === '_s')
							{
								
								$objects = [];
								foreach ($values as $v) {
									$v = is_array($v) ? @$v['value'] : $v;
									$v = Util\toNumericArray($v);
									foreach ($v as $id) {
										$obj = Objects::getCachedObject($id);	
										$objects[] = empty($obj) ? '' : str_replace('Yes - ','',$obj->getHtmlSafeName());
									}
								}
								$caseSd[$sfn] = implode(",", $objects);
							}
							else
							{
								$caseSd[$sfn] = $values[0]['value'];
							}
						}
					}
				}
			}
			
			
			if (!empty($p['data']['_referralstatus']) && !empty($objectId)) { //
				if ($p['data']['_referralstatus'] != 1155)
				{
					$caseSd['referrals_completed'][] = $objectId;
					$caseSd['referrals_started'] = array_diff($caseSd['referrals_started'], [$objectId]);
				}
			}
	
			if (!empty($p['data']['_referralneeded'])) { //assessment
				if (!empty($p['data']['_clienthavefemanumber']['childs']['_femanumber']))
				{
					$caseSd['femanumber_s'] = $p['data']['_clienthavefemanumber']['childs']['_femanumber'];
				}
			    $caseSd['assessments_needed'] = array_diff($caseSd['assessments_needed'], [$templateId]);
				if (!in_array($templateId, $caseSd['assessments_completed']))
				{
					$caseSd['assessments_completed'][] = $templateId;
				}
				if ($p['data']['_referralneeded']['value'] == 686 || $p['data']['_referralneeded'] == 686)
				{
				if (!in_array($templateId, $caseSd['referrals_needed'])) {				
					$caseSd['referrals_needed'][] = $templateId;
					if (!empty($p['data']['_referralneeded']['childs']['_referralservice']))
					{
						$services = Util\toNumericArray($p['data']['_referralneeded']['childs']['_referralservice']);
						foreach ($services as $service) {
							$obj = Objects::getCachedObject($service); 
							$objData = $obj->getData();
							
							//"data":{"_referraltype":{"value":1371,"childs":{"_referralservice":1372}},"_referralstatus":595}}
							$data = [
								'pid' => $caseId,
								'title' => 'Referral',
								'template_id' => 607,
								'path' => 'Tree/Clients',
								'view' => 'edit',
								'name' => 'New Referral',
								'data' => [
									'_referralstatus' => 1155,
									'_referraltype' => [
										'value'=>$objData['pid'],
										'childs' =>[
										'_referralservice' => $service
										]
									]
								],
							];
							$objService = new Objects();
							$newReferral =$objService->create($data);
							$caseSd['referrals_started'][] = $newReferral['data']['id'];
						}
					}										
				}
				}
				else
				{
					$caseSd['referrals_needed'] = array_diff($caseSd['referrals_needed'], [$templateId]);
				}
			}
			
			$case->updateSysData();
			$solr = new Client();
			$solr->updateTree(['id' => $caseId]);
        }
		
    }
    
	protected function setParamsFromDelete($p)
    {
		$p = $this->data;
		$caseId = $p['pid'];
		$templateId = $p['template_id'];

		
        if ($caseId) {
            $case = Objects::getCachedObject($caseId);    
			$caseData = &$case->data;
			$caseSd = &$caseData['sys_data'];
			
			
/* add some values to the parent */
			$tpl = $this->getTemplate();

			if (!empty($tpl)) {
				$fields = $tpl->getFields();
				
				foreach ($fields as $f) {
					$values = $this->getFieldValue($f['name']);
					if (!empty($f['solr_column_name'])) {	
						$sfn = $f['solr_column_name']; // Solr field name
						unset($caseSd[$sfn]);
					}
				}
			}
			
			$caseSd['assessments_completed'] = array_diff($caseSd['assessments_completed'], [$templateId]);
			if (in_array($templateId, $caseSd['assessments_reported'])) {
                    $caseSd['assessments_needed'][] = $templateId;
			}
			if (in_array($templateId, $caseSd['referrals_needed'])) {
                    $caseSd['referrals_needed'] = array_diff($caseSd['referrals_needed'], [$templateId]);
			}			
			$case->updateSysData();
			$solr = new Client();
			$solr->updateTree(['id' => $caseId]);
        }
		
    }	
	
}