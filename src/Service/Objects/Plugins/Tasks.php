<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Search;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Tasks as TaskService;

/**
 * Class Tasks
 */
class Tasks extends Base
{
    public function getData($id = false)
    {
        $rez = [
            'success' => true,
        ];

        if (empty(parent::getData($id))) {
            return $rez;
        }

        $params = [
            'pid' => $this->id,
            'fq' => [
                '(template_type:task) OR (target_type:task)',
            ],
            'fl' => 'id,pid,name,template_id,date,date_end,cid,cdate,status',
            'sort' => 'cdate',
            'dir' => 'desc',
        ];

        $s = new Search();
        $sr = $s->query($params);
        foreach ($sr['data'] as $d) {
            $d['ago_text'] = @Util\formatDateTimePeriod(
                $d['date'],
                null,
                @Cache::get('session')->get('user')['cfg']['timezone']
            );
            $d['user'] = User::getDisplayName($d['cid'], true);

            TaskService::setTaskActionFlags($d);

            $rez['data'][] = $d;
        }

        return $rez;
    }
}
