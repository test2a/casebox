<?php

namespace Casebox\CoreBundle\Service\Plugins\DisplayColumns;

use Casebox\CoreBundle\Service\State;

/**
 * Class Grid
 */
class Grid extends Base
{
    protected $fromParam = 'grid';

    /**
     * @param int|null $param
     *
     * @return array
     */
    protected function getState($param = null)
    {
        $rez = State\DBProvider::getGridViewState($param);

        return $rez;
    }
}
