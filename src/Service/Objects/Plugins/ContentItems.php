<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Util;

class ContentItems extends Base
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
                '(template_type:object) OR (target_type:object)'
            )
            ,'fl' => 'id,pid,name,template_id,cdate,cid'
            ,'sort' => 'cdate'
            ,'dir' => 'desc'
        );

        $folderTemplates = Config::get('folder_templates');
        if (!empty($folderTemplates)) {
            $params['fq'][] = '!template_id:('.implode(' OR ', Util\toNumericArray($folderTemplates)).')';
        }

        $s = new \Casebox\CoreBundle\Service\Search();
        $sr = $s->query($params);
        foreach ($sr['data'] as $d) {
            $d['ago_text'] = Util\formatAgoTime($d['cdate']);
            $d['user'] = @User::getDisplayName($d['cid']);
            $rez['data'][] = $d;
        }

        return $rez;
    }
}
