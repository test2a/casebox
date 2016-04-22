<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Search;
use Casebox\CoreBundle\Service\User;

class TimeTracking extends Base
{
    public function getData($id = false)
    {
        $rez = [
            'success' => true,
            'data' => [],
        ];

        $prez = parent::getData($id);
        if (empty($prez)) {
            return $rez;
        }

        $params = [
            'pid' => $this->id,
            'fq' => [
                '(template_type:time_tracking)',
            ],
            'fl' => 'id,pid,name,template_id,date,cdate,cid,time_spent_i,time_spent_money_f',
            'sort' => 'date asc, cdate asc',
        ];

        $s = new Search();
        $sr = $s->query($params);

        foreach ($sr['data'] as $d) {
            $d['user'] = @User::getDisplayName($d['cid']);
            $d['time'] = gmdate("G\h i\m", $d['time_spent_i']);
            $d['cost'] = '$'.number_format(@$d['time_spent_money_f'], 2);
            $rez['data'][] = $d;
        }

        return $rez;
    }
}
