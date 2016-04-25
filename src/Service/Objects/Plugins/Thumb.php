<?php
namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Files as FilesService;
use Casebox\CoreBundle\Service\Util;

/**
 * Class Thumb
 */
class Thumb extends Base
{
    /**
     * @param integer|bool|false $id
     *
     * @return array
     */
    public function getData($id = false)
    {
        $rez = [
            'success' => true,
            'data' => [],
        ];

        $prez = parent::getData($id);
        if (empty($prez)) {
            return null;
        }

        $o = $this->getObjectClass();
        if (empty($o)) {
            return $rez;
        }
        $data = $o->getData();

        // Don't display thumb for images less then 1MB
        $maxDisplaySize = Util\coalesce(Config::get('images_display_size'), 1024 * 1024);

        if ((substr($data['content_type'], 0, 5) == 'image') && ($data['size'] < $maxDisplaySize)) {
            $preview = FilesService::generatePreview($data['id']);
            if (!empty($preview['filename'])) {
                $fn = Config::get('files_preview_dir').$preview['filename'];
                $rez['data']['html'] = $fn;
                if (file_exists($fn)) {
                    $rez['data']['html'] = str_replace('fit-img', 'click fit-img', file_get_contents($fn));
                }
            }
        } else {
            $rez['data']['cls'] = 'pr-th-' . FilesService::getExtension($data['name']);
        }

        return $rez;
    }

    /**
     * @return null|object
     */
    protected function getObjectClass()
    {
        $rez = parent::getObjectClass();

        if (!empty($rez)) {
            $rez->load();
        }

        return $rez;
    }
}
