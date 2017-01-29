<?php

namespace Casebox\CoreBundle\Service\Objects;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Security;
use Casebox\CoreBundle\Service\Tasks;
use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Log;

/**
 * Class Cases
 * Custom class for cases
 */
class Cases extends Object
{
    public static $STATUS_NONE = 0;

    public static $STATUS_OVERDUE = 1;

    public static $STATUS_ACTIVE = 2;

    public static $STATUS_CLOSED = 3;

    public static $STATUS_PENDING = 4;

    public static $USERSTATUS_NONE = 0;

    public static $USERSTATUS_ONGOING = 1;

    public static $USERSTATUS_DONE = 2;

    /**
     * Create a task with specified params
     *
     * @param array $p object properties
     *
     * @return int
     */
    public function create($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
        $this->data = $p;

        $this->setParamsFromData($p);

        return parent::create($p);
    }

    /**
     * Load custom data for tasks
     * Note: should be removed after tasks upgraded and custom task tables removed
     */
    protected function loadCustomData()
    {
        parent::loadCustomData();

        $d = &$this->data;

        if (empty($d['data'])) {
            $d['data'] = [];
        }

        // $cd = &$d['data']; //custom data
        // $sd = &$d['sys_data']; //sys_data

        Tasks::setTaskActionFlags($d);
    }

    /**
     * Update object
     *
     * @param array|bool|false $p Optional properties. If not specified then $this-data is used
     *
     * @return boolean
     */
    public function update($p = false)
    {
        if ($p === false) {
            $p = $this->data;
        }
        $this->data = $p;

        $this->setParamsFromData($p);

        return parent::update($p);
    }

    /**
     * Analyze object data and set 'wu' property in sys_data
     *
     * return newly assigned ids
     */
    protected function setFollowers()
    {
        $rez = parent::setFollowers();

        $d = &$this->data;
        $sd = &$d['sys_data'];

        //add creator as follower for tasks
        if (!in_array($d['cid'], $sd['wu'])) {
            $sd['wu'][] = intval($d['cid']);
            $rez[] = intval($d['cid']);
        }

        $oldAssigned = [];
        if (!empty($this->oldObject)) {
            $oldAssigned = Util\toNumericArray(@$this->oldObject->getFieldValue('assigned', 0)['value']);
        }

        $newAssigned = Util\toNumericArray(@$this->getFieldValue('assigned', 0)['value']);
        $diff = array_diff($newAssigned, $oldAssigned);
        $wu = empty($sd['wu']) ? [] : $sd['wu'];

        $wu = array_merge($wu, $diff);

        $rez = array_merge($rez, $newAssigned);

        // Analyze referenced users from description
        if (!empty($d['data']['description'])) {
            $uids = Util\getReferencedUsers($d['data']['description']);
            if (!empty($uids)) {
                $wu = array_merge($wu, $uids);
                $rez = array_merge($rez, $wu);
            }
        }
        $sd['wu'] = array_unique($wu);

        $rez = array_unique($rez);

        return $rez;
    }

    /**
     * Method to collect solr data from object data
     * according to template fields configuration
     * and store it in sys_data under "solr" property
     */
    protected function collectSolrData()
    {
        parent::collectSolrData();

        $d = &$this->data;
        $sd = &$d['sys_data'];
        $solrData = &$sd['solr'];

        $template = $this->getTemplate();

        $solrData['task_status'] = @$sd['task_status'];

		$assessments_reported = Util\toNumericArray($this->getFieldValue('assessments_reported', 0)['value']);
        if (!empty($assessments_reported)) {
            $solrData['assessments_reported'] = $assessments_reported;
        }

		$assessments_needed = Util\toNumericArray($this->getFieldValue('assessments_needed', 0)['value']);
        if (!empty($assessments_needed)) {
            $solrData['assessments_needed'] = $assessments_needed;
        }
		
        $user_ids = Util\toNumericArray($this->getFieldValue('assigned', 0)['value']);
        if (!empty($user_ids)) {
            $solrData['task_u_assignee'] = $user_ids;
        }

        $user_ids[] = @Util\coalesce($d['oid'], $d['cid']);

        $solrData['task_u_all'] = array_unique($user_ids);
		
		
		// Select only required properties for result
        $properties = [
            'race',
            'gender',
            'maritalstatus',
            'ethnicity',
            'language',
            'headofhousehold',
			'full_address',
			'task_d_closed',
			'assessments_reported',
			'assessments_needed',
			'assessments_completed',
			'assessments_started',
			'referrals_needed',
			'referrals_completed',
			'referrals_started',
			'task_u_done',
			'task_u_ongoing',
			'lat_lon',
			'county',
			'location_type',
        ];
        foreach ($properties as $property) {
			unset($solrData[$property]);
			if (!empty($sd[$property]))
			{
				$solrData[$property] = $sd[$property];
			}
        }
		if (!empty($sd['full_address']))
		{
			$results = $this->lookup($sd['full_address']);
			if ($results != null)
			{
				$solrData['lat_lon'] = $results['latitude'] .','.$results['longitude'];
				$solrData['full_address'] = $results['full_address'];
				$solrData['county'] = $results['county'];
				$solrData['location_type'] = $results['location_type'];	
			}
		}
		
        if (!empty($sd['task_d_closed'])) {
            $solrData['task_ym_closed'] = str_replace('-', '', substr($sd['task_d_closed'], 2, 5));
        }

        // Set class
        $solrData['cls'] = $template->formatValueForDisplay(
            $template->getField('color'),
            $this->getFieldValue('color', 0)['value'],
            false
        );
    }
	
    /**
     * 
     * http://www.andrew-kirkpatrick.com/2011/10/google-geocoding-api-with-php/
	 *
     */	
	protected function lookup($string){
 
	   $string = str_replace (" ", "+", urlencode($string));
	   $details_url = "http://maps.googleapis.com/maps/api/geocode/json?address=".$string."&sensor=false";
	 
	   $ch = curl_init();
	   curl_setopt($ch, CURLOPT_URL, $details_url);
	   curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	   $response = json_decode(curl_exec($ch), true);
	 
	   // If Status Code is ZERO_RESULTS, OVER_QUERY_LIMIT, REQUEST_DENIED or INVALID_REQUEST
	   if ($response['status'] != 'OK') {
		return null;
	   }
	 
	   //print_r($response);
	   $geometry = $response['results'][0]['geometry'];
	   
	   $location = array();

  foreach ($response['results'][0]['address_components'] as $component) {
    switch ($component['types']) {
      case in_array('street_number', $component['types']):
        $location['street_number'] = $component['long_name'];
      case in_array('route', $component['types']):
        $location['street'] = $component['long_name'];
      case in_array('sublocality', $component['types']):
        $location['sublocality'] = $component['long_name'];
      case in_array('locality', $component['types']):
        $location['locality'] = $component['long_name'];
      case in_array('administrative_area_level_2', $component['types']):
        $location['admin_2'] = $component['long_name'];
      case in_array('administrative_area_level_1', $component['types']):
        $location['admin_1'] = $component['long_name'];
      case in_array('postal_code', $component['types']):
        $location['postal_code'] = $component['long_name'];
      case in_array('country', $component['types']):
        $location['country'] = $component['long_name'];
    }

  }
	   
	   
	   
		$array = array(
			'longitude' => $geometry['location']['lng'],
			'latitude' => $geometry['location']['lat'],
			'location_type' => $geometry['location_type'],
			'full_address' => $response['results'][0]['formatted_address'],
			'county' => $location['admin_2']
		);
	 
		return $array;
	 
	}
		
    /**
     * Set "sys_data" params from object data
     *
     * @param array &$p
     */
    protected function setParamsFromData(&$p)
    {
        $d = &$p['data'];

        if (empty($d['sys_data'])) {
            $d['sys_data'] = [];
        }

        $sd = &$p['sys_data'];
		
		unset($sd['full_address']);
		
		// Select only required properties for result
        $properties = [
            'race',
            'gender',
            'maritalstatus',
            'ethnicity',
            'language',
			'age',
            'headofhousehold'
        ];
        foreach ($properties as $property) {
			unset($sd[$property]);
			if ($this->getFieldValue('_' . $property, 0)['value'] != null) {
				$obj = Objects::getCachedObject($this->getFieldValue('_' . $property, 0)['value']);
				$sd[$property] = empty($obj) ? '' : $obj->getHtmlSafeName();
			}
        }
		$sd['full_address'] = '';
		
        if ($this->getFieldValue('_street', 0)['value'] != null) {
         $sd['full_address'] = $this->getFieldValue('_street', 0)['value'];
        }
		
        if ($this->getFieldValue('_city', 0)['value'] != null) {
         $sd['full_address'] = $sd['full_address']. " " . $this->getFieldValue('_city', 0)['value'];
        }
		
        if ($this->getFieldValue('_state', 0)['value'] != null) {
         $sd['full_address'] = $sd['full_address'] . " " . $this->getFieldValue('_state', 0)['value'];
        }

        if ($this->getFieldValue('_zip', 0)['value'] != null) {
         $sd['full_address'] = $sd['full_address'] . " " . $this->getFieldValue('_zip', 0)['value'];
        }		
		
        $sd['task_due_date'] = $this->getFieldValue('due_date', 0)['value'];
        $sd['task_due_time'] = $this->getFieldValue('due_time', 0)['value'];

        $sd['task_allday'] = empty($sd['task_due_time']);

        //set date_end to be saved in tree table
        if (empty($sd['task_due_date'])) {
            $p['date_end'] = null;
        } else {
            $p['date_end'] = $sd['task_due_date'];
            if (!$sd['task_allday']) {
                $p['date_end'] = substr($sd['task_due_date'], 0, 10).' '.$sd['task_due_time'];
            }
        }

        // Set assigned users
        if (empty($sd['task_u_done'])) {
            $sd['task_u_done'] = [];
        }

		if (empty($sd['assessments_completed'])) {
            $sd['assessments_completed'] = [];
        }
		
		if (empty($sd['assessments_reported'])) {
            $sd['assessments_reported'] = [];
        }
		
		$ASSESSMENT_MAP = array(
		   1511=>510, //behavioral
		   1497=>533,//child
		   1507=>553,//clothing
		   1508=>482, //employment
		   1506=>1120,//fema
		   1515=>455,//finance
		   1504=>505, //food
		   1510=>559,//furniture
		   1512=>489,//health
		   1514=>440, //housing
		   1501=>656,//language
		   1505=>1175,//legal
		   1498=>651, //senior
		   1513=>172 //transportation
		);
		
		$identified_unmet_needs = Util\toNumericArray($this->getFieldValue('identified_unmet_needs', 0)['value']);
		$at_risk_population = Util\toNumericArray($this->getFieldValue('at_risk_population', 0)['value']);
		foreach($ASSESSMENT_MAP as $identified=>$assessment){
			if (in_array($identified,$identified_unmet_needs)||in_array($identified,$at_risk_population))
			{
				$assessments_reported[] = $assessment;
			}
		 }		
				
		$sd['assessments_reported'] = $assessments_reported;
		
		//$sd['assessments_completed'] = array_intersect($assessments_reported, $sd['assessments_completed']);
		
		$sd['assessments_needed'] = array_diff($assessments_reported, $sd['assessments_completed']);
		
        $assigned = Util\toNumericArray($this->getFieldValue('assigned', 0)['value']);
	
		if (!empty($assigned)) {
			$d['oid'] = $assigned[0];
		}
		
		
        $sd['task_u_ongoing'] = array_diff($assigned, $sd['task_u_done']);

        // Set status
        $dateEnd = empty($p['date_end']) ? null : Util\dateISOToMysql($p['date_end']);

        $status = static::$STATUS_ACTIVE;

        if (!empty($sd['task_d_closed'])) {
            $status = static::$STATUS_CLOSED;

        } elseif (!empty($dateEnd)) {
            if (strtotime($dateEnd) < strtotime('now')) {
                $status = static::$STATUS_OVERDUE;
            }
        }
		
        $sd['task_status'] = $status;
    }

    /**
     * Mark the task active
     * @return void
     */
    public function markActive()
    {
        $d = &$this->data;
        $sd = &$d['sys_data'];

        unset($sd['task_d_closed']);

        $this->setParamsFromData($d);
    }

    /**
     * Mark the task active, reset done user list and update into db
     * @return void
     */
    public function setActive()
    {
        if (!$this->loaded) {
            $this->load();
        }

        $this->markActive();

        unset($this->data['sys_data']['task_u_done']);

        $this->update();

        $this->logAction('reopen', ['old' => &$this]);
    }

    /**
     * Mark the task as closed
     * @return void
     */
    public function markClosed()
    {
        $d = &$this->data;
        $sd = &$d['sys_data'];

        $sd['task_status'] = static::$STATUS_CLOSED;
        $sd['task_d_closed'] = date('Y-m-d\TH:i:s\Z');
    }

    /**
     * Mark the task as closed and update into db
     * @return void
     */
    public function setClosed()
    {
        if (!$this->loaded) {
            $this->load();
        }

        $this->markClosed();

        $this->logAction('close', ['old' => &$this]);
    }

    /**
     * Simple function to check if task is closed
     * @return boolean
     */
    public function isClosed()
    {
        return ($this->getStatus() == static::$STATUS_CLOSED);
    }

    /**
     * Get task status
     * @return int
     */
    public function getStatus()
    {
        $d = &$this->data;
        $sd = &$d['sys_data'];

        $rez = empty($sd['task_status']) ? static::$STATUS_NONE : $sd['task_status'];

        return $rez;
    }

    /**
     * Get task status text
     *
     * @param integer|bool|false $status
     *
     * @return string
     */
    public function getStatusText($status = false)
    {
        if ($status === false) {
            $status = $this->getStatus();
        }

        return $this->trans('caseStatus'.$status, '');
    }

    /**
     * Get the css class corresponding for status color
     *
     * @param int $status
     *
     * @return string | null
     */
    public function getStatusCSSClass($status = false)
    {
        if ($status === false) {
            $status = $this->getStatus();
        }

        $rez = 'task-status';

        switch ($this->getStatus()) {
            case static::$STATUS_OVERDUE:
                $rez .= ' task-status-overdue';
                break;

            case static::$STATUS_ACTIVE:
                $rez .= ' task-status-active';
                break;

            case static::$STATUS_CLOSED:
                $rez .= ' task-status-closed';
                break;
        }

        return $rez;
    }

    /**
     * Get user status for loaded task
     *
     * @param  int|bool|false $userId
     *
     * @return integer
     */
    public function getUserStatus($userId = false)
    {
        if ($userId == false) {
            $userId = User::getId();
        }

        $d = &$this->data;
        $sd = &$d['sys_data'];

        if (in_array($userId, $sd['task_u_ongoing'])) {
            return static::$USERSTATUS_ONGOING;
        }

        if (in_array($userId, $sd['task_u_done'])) {
            return static::$USERSTATUS_DONE;
        }

        return static::$USERSTATUS_NONE;
    }

    /**
     * Change user status for loaded task
     *
     * @param integer $status
     * @param integer|bool|false $userId
     *
     * @return boolean
     */
    public function setUserStatus($status, $userId = false)
    {
        $rez = false;
        $action = '';
        $currentUserId = User::getId();

        if ($userId == false) {
            $userId = $currentUserId;
        }

        $d = &$this->data;
        $sd = &$d['sys_data'];

        switch ($status) {
            case static::$USERSTATUS_ONGOING:
                if (in_array($userId, $sd['task_u_done'])) {
                    $sd['task_u_done'] = array_diff($sd['task_u_done'], [$userId]);
                    $sd['task_u_ongoing'][] = $userId;
                    unset($sd['task_u_d_closed'][$userId]);

                    $rez = true;

                    $action = ($currentUserId == $userId) ? 'reopen' : 'completion_decline';
                }
                break;
            case static::$USERSTATUS_DONE:
                if (in_array($userId, $sd['task_u_ongoing'])) {
                    $sd['task_u_ongoing'] = array_diff($sd['task_u_ongoing'], [$userId]);
                    $sd['task_u_done'][] = $userId;
                    $sd['task_u_d_closed'][$userId] = date(DATE_ISO8601);

                    $rez = true;

                    $action = ($currentUserId == $userId) ? 'complete' : 'completion_on_behalf';
                }
                break;
        }

        if ($rez) {
            $this->checkAutoclose();
            $this->logAction($action, ['old' => &$this, 'forUserId' => $userId]);
            // $this->updateSysData();
        }

        return $rez;
    }

    /**
     * Check if a task status should be changed after user status change
     */
    public function checkAutoclose()
    {
        $d = &$this->data;
        $sd = &$d['sys_data'];

        if (empty($sd['task_u_ongoing'])) {
            $this->markClosed();
        } else {
            $this->markActive();
        }
    }

    /**
     * Get action flags that a user can do to task
     *
     * @param integer|bool|false $userId
     *
     * @return array
     */
    public function getActionFlags($userId = false)
    {
        if ($userId === false) {
            $userId = User::getId();
        }

        $isAdmin = Security::isAdmin($userId);
        $isOwner = $this->isOwner($userId);
        $isClosed = $this->isClosed();
        $canEdit = !$isClosed && ($isAdmin || $isOwner);
		$data = $this->getData();
        $sd = &$data['sys_data'];
		//	Cache::get('symfony.container')->get('logger')->error(
	//		'sup',
//			$sd
//		);	

        $rez = [
            // 'edit' => $canEdit
			'assessments'=>array_values($sd['solr']['assessments_needed']),
			'referrals'=>array_values($sd['solr']['referrals_started']),
            'close' => $canEdit,
            'reopen' => ($isClosed && $isOwner),
            'complete' => (!$isClosed && ($this->getUserStatus($userId) == static::$USERSTATUS_ONGOING)),
        ];

        return $rez;
    }

    /**
     * Method to get end date for the task
     * @return string | null
     */
    public function getEndDate()
    {
        $rez = null;

        $d = &$this->data;
        $sd = &$d['sys_data'];

        if (!empty($sd['task_due_date'])) {
            $rez = $sd['task_due_date'];
            if (!empty($sd['task_due_time'])) {
                $rez = substr($rez, 0, 11).$sd['task_due_time'].'Z';
                $rez = Util\userTimeToUTCTimezone($rez);
            }
        }

        return $rez;
    }

    /**
     * Generate html preview for a case
     *
     * @param int $id task id
     *
     * @return array
     */
    public function getPreviewBlocks()
    {
        $pb = parent::getPreviewBlocks();

        $data = $this->getData();
        $sd = &$data['sys_data'];

        $template = $this->getTemplate();

		//$actionsLine = '';
		$addressLine = '';
        $demographicsLine = '';
		$dateLines = '';
        $ownerRow = '';
        $assigneeRow = '';
        $contentRow = '';
		$identifiedNeedsLine = '';
		$atRiskLine = '';
        $coreUri = $this->configService->get('core_uri');

		/*if (!empty($sd['solr']['assessments_completed']))
		{
			$actionsLine = count($sd['solr']['assessments_completed']) . " Assessments Completed -";	
		}
		
		if (!empty($sd['solr']['assessments_needed'])) {
			$actionsLine = count($sd['solr']['assessments_needed']) . " Assessments Needed - ";
		}*/
		
		if (!empty($sd['solr']['gender'])) {
			$demographicsLine = $sd['solr']['gender'] . " - ";
		}
		else
		{
			$demographicsLine = "Gender not collected" . " - ";
		}		
		if (!empty($sd['solr']['race'])) {
			$demographicsLine = $demographicsLine . $sd['solr']['race'] . " - ";
		}

		if (!empty($sd['solr']['ethnicity'])) {
			$demographicsLine = $demographicsLine . $sd['solr']['ethnicity'] . " - ";
		}

		if (!empty($sd['solr']['birthdate_dt'])) {
			$demographicsLine = $demographicsLine . Util\formatMysqlDate($sd['solr']['birthdate_dt'], Util\getOption('short_date_format')) . " - ";
		}
		
		if (!empty($sd['solr']['language'])) {
			$demographicsLine = $demographicsLine . $sd['solr']['language'] . " - ";
		}

		if (!empty($sd['solr']['emailaddress_s'])) {
			$emailLine = $sd['solr']['emailaddress_s'] . " - ";
		}
		else
		{
			$emailLine = "Email not collected" . " - ";
		}		
		
		if (!empty($sd['solr']['phonenumber_s'])) {
			$emailLine = $emailLine . $sd['solr']['phonenumber_s'] . " - ";
		}
		
		if (!empty($sd['solr']['maritalstatus'])) {
			$emailLine =  $emailLine .$sd['solr']['maritalstatus'] . " - ";
		}		
		
		if (!empty($sd['solr']['full_address'])) {
			$addressLine = $sd['solr']['full_address']. " - ";
		}
		else
		{
			$addressLine = "No address listed" . " - ";
		}
		if (!empty($sd['solr']['county'])) {
			$addressLine = $addressLine . $sd['solr']['county']. " - ";
		}
				
        $userService = Cache::get('symfony.container')->get('casebox_core.service.user');

        //create date and status row
        $ed = $this->getEndDate();

        if (!empty($ed)) {
            $endDate = Util\formatTaskTime($ed, !$sd['task_allday']);

            $dateLines = '<tr><td class="prop-key">'.$this->trans('Due').':</td><td>'.$endDate.'</td></tr>';
            // $dateLine .= '<div class="date">' . $endDate . '</div>';
        }

        if (!empty($sd['task_d_closed'])) {
            $dateLines .= '<tr><td class="prop-key">'.
                $this->trans('Completed').':</td><td>'.
                Util\formatAgoTime($sd['task_d_closed']).'</td></tr>';
        }

        // Create owner row
        $v = $this->getOwner();
        if (!empty($v)) {
            $cn = User::getDisplayName($v);
            $cdt = Util\formatAgoTime($data['cdate']);
            $cd = Util\formatDateTimePeriod(
                $data['cdate'],
                null,
                @Cache::get('session')->get('user')['cfg']['timezone']
            );

            $ownerRow = '<tr><td class="prop-key">'.$this->trans('Owner').':</td><td>'.
                '<table class="prop-val people"><tbody>'.
                '<tr><td class="user"><img class="photo32" src="'.
                $coreUri.'photo/'.$v.'.jpg?32='.$userService->getPhotoParam($v).
                '" style="width:32px; height: 32px" alt="'.$cn.'" title="'.$cn.'"></td>'.
                '<td><b>'.$cn.'</b><p class="gr">'.$this->trans('Created').': '.
                '<span class="dttm" title="'.$cd.'">'.$cdt.'</span></p></td></tr>';
        }

        // Create assignee row
        $v = $this->getFieldValue('assigned', 0);

        if (!empty($v['value'])) {

            $isOwner = $this->isOwner();
            $assigneeRow .= '<tr><td class="prop-key">'.$this->trans(
                    'Client Assigned'
                ).':</td><td><table class="prop-val people"><tbody>';
            $v = Util\toNumericArray($v['value']);

            $dateFormat = Util\getOption('long_date_format').' H:i:s';

            foreach ($v as $id) {
                $un = User::getDisplayName($id);
                $completed = ($this->getUserStatus($id) == static::$USERSTATUS_DONE);

                $cdt = ''; //completed date title
                $dateText = '';

                if ($completed && !empty($sd['task_u_d_closed'][$id])) {
                    $cdt = Util\formatMysqlDate($sd['task_u_d_closed'][$id], $dateFormat);
                    $dateText = ': '.Util\formatAgoTime($sd['task_u_d_closed'][$id]);
                }

                $assigneeRow .= '<tr><td class="user"><div style="position: relative">'.
                    '<img class="photo32" src="'.$coreUri.'photo/'.$id.'.jpg?32='.$userService->getPhotoParam($id).
                    '" style="width:32px; height: 32px" alt="'.$un.'" title="'.$un.'">'.
                    ($completed ? '<img class="done icon icon-tick-circle" src="/css/i/s.gif" />' : "").
                    '</div></td><td><b>'.$un.'</b>'.
                    '<p class="gr" title="'.$cdt.'">'.(
                    $completed
                        ? $this->trans('Completed').$dateText.
                        ($isOwner
                            ? ' <a class="bt task-action click" action="markincomplete" uid="'.$id.'">'.
                            $this->trans('revoke').'</a>'
                            : ''
                        )
                        : 'Not Complete'//$this->trans('waitingForAction').
                       // ($isOwner
                       //     ? ' <a class="bt task-action click" action="markcomplete" uid="'.$id.'">'.
                       //     $this->trans('complete').'</a>'
                       //     : ''
                       // )
                    ).'</p></td></tr>';
            }
        }

        // Create description row
        $v = $this->getFieldValue('description', 0);
        if (!empty($v['value'])) {
            $tf = $template->getField('description');
            $v = $template->formatValueForDisplay($tf, $v);
            $contentRow = '<tr><td class="prop-val" colspan="2">'.$v.'</td></tr>';
        }

        // Insert rows
        $p = $pb[0];
        $pos = strrpos($p, '<tbody>');
        if ($pos !== false) {
            $p = substr($p, $pos + 7);
            $pos = strrpos($p, '</tbody>');
            if ($pos !== false) {
                $p = substr($p, 0, $pos);
            }
        } else {
            $p = '';
        }
		
        $rtl = empty($this->configService->get('rtl')) ? '' : ' drtl';

        $pb[0] = '<table class="obj-preview'.$rtl.'"><tbody>'.
            $dateLines.
            $p.
            $ownerRow. '</tbody></table></td></tr>'.
            $assigneeRow. '</tbody></table></td></tr>'.
            $contentRow.
            '<tbody></table>';
        $pb[1] = 
            '<div class="info">'.
			trim($demographicsLine, " - ").'<br/>'.
			trim($emailLine, " - ").'<br/>'.
			trim($addressLine, " - ").'<br/>';
        
		// Create description row
        $v = $this->getFieldValue('identified_unmet_needs', 0);
        if (!empty($v['value'])) {
            $tf = $template->getField('identified_unmet_needs');
            $identifiedNeedsLine = $template->formatValueForDisplay($tf, $v);
        }

		// Create description row
        $v = $this->getFieldValue('at_risk_population', 0);
        if (!empty($v['value'])) {
            $tf = $template->getField('at_risk_population');
            $atRiskLine = $template->formatValueForDisplay($tf, $v);
        }
		
		$pb[2] = 
            '<table class="obj-preview'.$rtl.'"><tbody>'.
			'<tr class="prop-header"><th colspan="2" style>Assigned Case Manager</th><th colspan="3" style>Self Reported/Identified Population and Needs</th></tr>'.
            $ownerRow.'</tbody></table></td><td class="prop-key">Special/At Risk Population</td><td class="prop-val" colspan="2">'.$atRiskLine.'</td></tr>'.
            $assigneeRow. '</tbody></table><td class="prop-key">Identified Needs</td><td class="prop-val" colspan="2">'.$identifiedNeedsLine.'</td></tr>'.
			$contentRow.
            '<tbody></table>';		
        $pb[3] = 
            '<table class="obj-preview'.$rtl.'"><tbody>'.
			'<tr class="prop-header"><th colspan="3" style>'.count(array_intersect($sd['solr']['assessments_completed'], $sd['solr']['assessments_reported'])).' out of '.count($sd['solr']['assessments_reported']).' assessments completed. '.count($sd['solr']['assessments_needed']).' remain to be completed</td></tr>'.
            '<tbody></table>';	
        $pb[4] = 
            '<table class="obj-preview'.$rtl.'"><tbody>'.
			'<tr class="prop-header"><th colspan="3" style>'.count($sd['solr']['referrals_needed']).' assessments required referrals. '.count($sd['solr']['referrals_started']).' services need to be completed</td></tr>'.
            '<tbody></table>';			
        $pb[5] = 
            '<table class="obj-preview'.$rtl.'"><tbody>'.
			'<tr class="prop-header"><th colspan="3" style>Current Status: '.$this->getStatusText().'</td></tr>'.
            '<tbody></table>'.
			$this->getPreviewActionsRow();			
		return $pb;
    }
}