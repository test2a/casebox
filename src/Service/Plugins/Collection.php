<?php

namespace Casebox\CoreBundle\Service\Plugins;

use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Service\Util;

/**
 * Templates collection class
 */
class Collection
{
    /**
     * Array of Plugin classes
     * @var array
     */
    public $items = [];

    /**
     * Load all plugins from database
     */
    public function loadAll()
    {
        if (!empty($this->loaded)) {
            return $this->items;
        }

        $this->items = [];

        $recs = [];
        // $recs = DM\Plugins::readAll();

        // Util\sortRecordsArray($recs, 'order', 'asc', 'asInt');

        foreach ($recs as $r) {
            $this->items[$r['name']] = $r;
        }

        return $this->loaded = true;
    }

    /**
     * Get plugin data by its name
     *
     * @return array
     */
    public function getData($name)
    {
        $this->loadAll();
        if (!empty($this->items[$name])) {
            return $this->items[$name];
        }

        return null;
    }

    /**
     * Get active plugin list as an associative array ($pluginName => $pluginConfig)
     * @return string
     */
    public function getActivePlugins()
    {
        $rez = [];
        $this->loadAll();

        foreach ($this->items as $name => $data) {
            if ($data['active'] == 1) {
                $rez[$name] = $data['cfg'];
            }
        }

        return $rez;
    }
}
