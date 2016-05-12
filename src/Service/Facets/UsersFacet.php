<?php

namespace Casebox\CoreBundle\Service\Facets;

use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\Users;

/**
 * Class UsersFacet
 */
class UsersFacet extends StringsFacet
{
    /**
     * @param array $options
     *
     * @return array
     */
    public function getClientData($options = [])
    {
        $rez = [
            'f' => $this->field,
            'title' => $this->getTitle(),
            'items' => [],
        ];

        foreach ($this->solrData as $k => $v) {
            $rez['items'][$k] = [
                'name' => User::getDisplayName($k),
                'count' => $v,
            ];

            if (!empty($options['colors'])) {
                $rez['items'][$k]['cls'] = 'user-color-'.$k;
            }
        }

        return $rez;
    }
}
