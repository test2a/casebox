<?php
namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Objects;

class Html extends Base
{
    public function getData($id = false)
    {
        $config = $this->config;

        if (!$this->isVisible() || empty($config['fn'])) {
            return null;
        }

        $rez = parent::getData($id);

        if (empty($this->id)) {
            return $rez;
        }

        $rez['data'] = $this->getFunctionResult($config['fn']);

        return $rez;
    }
}
