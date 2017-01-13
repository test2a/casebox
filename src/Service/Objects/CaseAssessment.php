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
		
		$this->setParamsFromData($p);
        
		return parent::create($p);
    }
	
    public function update($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
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

        if ($caseId) {
            $case = Objects::getCachedObject($caseId);    
			$caseData = &$case->data;
			$caseSd = &$caseData['sys_data'];
						Cache::get('symfony.container')->get('logger')->error(
			'hey',
			$p['data']
		);	
			if (in_array($templateId, $caseSd['assessments_needed'])) {
                    $caseSd['assessments_needed'] = array_diff($caseSd['assessments_needed'], [$templateId]);
                    $caseSd['assessments_completed'][] = $templateId;
			}
			if (!empty($p['data']['_referralneeded'])) {
				if ($p['data']['_referralneeded'] == 686)
				{
					if (!in_array($templateId, $caseSd['referrals_needed'])) {					
						$caseSd['referrals_needed'][] = $templateId;
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
			if (in_array($templateId, $caseSd['assessments_completed'])) {
                    $caseSd['assessments_completed'] = array_diff($caseSd['assessments_completed'], [$templateId]);
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