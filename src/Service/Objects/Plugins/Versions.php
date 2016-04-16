<?php
namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Service\User;

/**
 * Class Versions
 */
class Versions extends Base
{
    public function getData($id = false)
    {
        $rez = [
            'success' => true,
        ];

        parent::getData($id);

        $o = Objects::getCachedObject($this->id);

        if (!empty($o)) {
            $data = $o->getData();

            if (!empty($data['versions'])) {
                $rez['data'] = $data['versions'];

                foreach ($rez['data'] as &$version) {
                    $version['ago_text'] = @Util\formatAgoTime(Util\coalesce($version['udate'], $version['cdate']));
                    $version['user'] = @User::getDisplayName(Util\coalesce($version['uid'], $version['uid']), true);
                }
            }
        }

        return $rez;
    }
}
