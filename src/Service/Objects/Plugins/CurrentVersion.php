<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;

/**
 * Class CurrentVersion
 */
class CurrentVersion extends Base
{
    public function getData($id = false)
    {
        $rez = [
            'success' => true,
        ];

        parent::getData($id);

        $o = Objects::getCachedObject($this->id);
        $data = $o->getData();

        // Show current version only if have more other versions
        if (!empty($data['versions'])) {
            $data['ago_text'] = Util\formatAgoTime(Util\coalesce($data['udate'], $data['cdate']));
            $data['user'] = User::getDisplayName(Util\coalesce($data['uid'], $data['oid'], $data['cid']), true);
            $data['cls'] = 'sel';

            $rez['data'] = [$data];
        }

        return $rez;
    }
}
