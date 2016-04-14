<?php

namespace DisplayColumns;

use Casebox\CoreBundle\Service\State;

class Grid extends Base
{
    protected $fromParam = 'grid';

    protected function getState($param = null)
    {
        $rez = State\DBProvider::getGridViewState($param);

        return $rez;
    }
}
