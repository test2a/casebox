<?php

namespace Casebox\CoreBundle\Service;

/**
 * Class BrowserView
 */
class BrowserView extends Browser
{
    public function getChildren($p)
    {
        $p['showFoldersContent'] = true;
        if (@$p['from'] == 'calendar') {
            $p['fl'] = 'id,cid,date,date_end,status,template_id,name,cls';
        }

        // Set default folder to root on fulltext search, otherwise facets will not be displayed for empty path
        if (!empty($p['query']) && (empty($p['path']) || ($p['path'] == '/'))) {
            $p['path'] = '/'.$this->getRootFolderId();
        }

        $rez = parent::getChildren($p);

        return $rez;
    }
}
