<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Objects;
use Casebox\CoreBundle\Service\Templates\SingletonCollection;

/**
 * Class Meta
 */
class Meta extends ObjectProperties
{
    public function getData($id = false)
    {
        $rez = parent::getData($id);

        if (empty($rez)) {
            return null;
        }

        $template = SingletonCollection::getInstance()->getTemplate($rez['data']['template_id']);
        $noTemplateFields = empty($template->getData()['fields']);

        if (empty($rez['data']['preview']) && $noTemplateFields) {
            unset($rez['data']);
        } else {
            $preview = implode('', $rez['data']['preview']);
            if (empty($preview) && $noTemplateFields) {
                unset($rez['data']);
            }
        }

        return $rez;
    }
}
