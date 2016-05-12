<?php

namespace Casebox\CoreBundle\Service\Facets;

/**
 * Class IntFacet
 */
class IntFacet extends StringsFacet
{
    public function getClientData($options = [])
    {
        $rez = [
            'f' => $this->field,
            'title' => $this->getTitle(),
            'items' => [],
        ];

        foreach ($this->solrData as $k => $v) {
            $rez['items'][$k] = [
                'name' => $k,
                'count' => $v,
            ];
        }

        return $rez;
    }
}
