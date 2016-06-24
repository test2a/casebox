<?php

namespace Casebox\CoreBundle\Service;

use Symfony\Component\HttpFoundation\Session\Storage\NativeSessionStorage;

/**
 * Class DomainSessionStorage
 */
class DomainSessionStorage extends NativeSessionStorage
{
    /**
     * Implements setOptions().
     *
     * {@inheritDoc}
     */
    public function setOptions(array $options)
    {
        if (isset($_SERVER['REQUEST_URI'])) {
            $options["cookie_path"] = \AppEnv::getRequestEnvironment();
        }

        return parent::setOptions($options);
    }
}
