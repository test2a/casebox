<?php

namespace DisplayColumns;

use Casebox\CoreBundle\Service\Objects;

class FormEditor extends Base
{
    protected $fromParam = 'formEditor';

    /**
     * Get display columns for field
     * @return array
     */
    public function getDC()
    {
        $rez = [];

        if (empty($this->params['inputParams']['fieldId'])) {
            return $rez;
        }

        $fieldId = $this->params['inputParams']['fieldId'];

        $field = new Objects\TemplateField($fieldId, false);

        $fieldData = $field->load();

        if (!empty($fieldData['cfg']['DC'])) {
            $rez = $fieldData['cfg']['DC'];
        }

        return [
            'data' => $rez,
        ];
    }
}
