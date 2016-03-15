<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Cache;

class Tasks extends Base
{

    public function getData($id = false)
    {

        $rez = array(
            'success' => true
        );

        if (empty(parent::getData($id))) {
            return $rez;
        }

        $params = array(
            'pid' => $this->id
            ,'fq' => array(
                '(template_type:task) OR (target_type:task)'
            )
            ,'fl' => 'id,pid,name,template_id,date,date_end,cid,cdate,status'
            ,'sort' => 'cdate'
            ,'dir' => 'desc'
        );

        $s = new \Casebox\CoreBundle\Service\Search();
        $sr = $s->query($params);
        foreach ($sr['data'] as $d) {
            $d['ago_text'] = @Util\formatDateTimePeriod($d['date'], null, @Cache::get('session')->get('user')['cfg']['timezone']);
            $d['user'] = User::getDisplayName($d['cid'], true);

            \Casebox\CoreBundle\Service\Tasks::setTaskActionFlags($d);

            $rez['data'][] = $d;
        }

        return $rez;
    }
}
