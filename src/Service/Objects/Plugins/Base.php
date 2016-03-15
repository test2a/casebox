<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Objects;

/**
 * Class Base
 */
class Base
{
    /**
     * Id of the objects for which the plugin is displayed
     * @var integer|null
     */
    protected $id = null;

    /**
     * Base constructor
     */
    public function __construct($id = null)
    {
        $this->id = $id;
    }

    /**
     * Get plugin data for given object id
     * @return array
     */
    public function getData($id = false)
    {
        if ($id === false) {
            $id = $this->id;
        } else {
            $this->setId($id);
        }

        if (!is_numeric($id)) {
            // ID was not specified
            return null;
        }

        return ['success' => true];
    }

    /**
     * @param int $id
     */
    public function setId($id)
    {
        if ($this->id != $id) {
            unset($this->objectClass);
        }
        $this->id = $id;
    }

    /**
     * @return null|object
     */
    protected function getObjectClass()
    {
        $rez = null;

        if (empty($this->objectClass) && !empty($this->id)) {
            $this->objectClass = Objects::getCachedObject($this->id);
            $rez = &$this->objectClass;
        }

        return $rez;
    }
}
