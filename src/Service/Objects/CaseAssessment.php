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
        $this->setParamsFromData($p);

        return parent::update($p);
    }
		
    /**
     * Set "sys_data" params from object data
     *
     * @param array &$p
     */
    protected function setParamsFromData(&$p)
    {
		$caseId = $this->data['case_id'];
		

        if ($caseId) {
            $case = Objects::getCachedObject($caseId);    
			//$tpl->setSysDataProperty('task_u_ongoing', null);
			//$case->setActive();
			$case->setClosed();//setSysDataProperty('task_d_closed', null);
			Objects::updateCaseUpdateInfo($caseId);
			$solr = new Client();
			$solr->updateTree(['id' => $caseId]);
        }
		
    }
}
