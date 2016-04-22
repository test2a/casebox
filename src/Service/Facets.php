<?php

namespace Casebox\CoreBundle\Service;

/**
 * Class Facets
 */
class Facets
{
    public static function getFacetObject($config)
    {
        $type = 'Casebox\\CoreBundle\\Service\\Facets\\StringsFacet';

        if (!empty($config['type'])) {
            $configType = '\\Casebox\\CoreBundle\\Service\\Facets\\'.ucfirst($config['type']).'Facet';

            if (class_exists($configType)) {
                $type = $configType;
            }
        }

        return new $type($config);
    }
}
