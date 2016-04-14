<?php

namespace Casebox\CoreBundle\Service\Objects\Plugins;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\Files;
use Casebox\CoreBundle\Service\Objects\Object;
use Casebox\CoreBundle\Service\Search;
use Casebox\CoreBundle\Service\User;
use Casebox\CoreBundle\Service\DataModel as DM;
use Casebox\CoreBundle\Service\Util;

/**
 * Class Comments
 */
class Comments extends Base
{
    /**
     * Get default set of comments for given object id
     *
     * @param int|null $id
     *
     * @return array response
     */
    public function getData($id = false)
    {
        return $this->loadMore(['id' => $id]);
    }

    /**
     * Load next set of comments (not all are loaded by default)
     *
     * @param  array $p
     *
     * @return array  response
     */
    public function loadMore($p)
    {
        $rez = [
            'success' => true,
            'data' => [],
        ];

        if (empty(parent::getData($p['id']))) {
            return $rez;
        }

        $commentTemplateIds = DM\Templates::getIdsByType('comment');
        if (empty($commentTemplateIds)) {
            return $rez;
        }

        $limit = empty($p['beforeId']) ? 4 : 10;
        $limit = Config::get('max_load_comments', $limit);

        $params = [
            'pid' => $this->id,
            'system' => '[0 TO 2]',
            'fq' => [
                'template_id:('.implode(' OR ', $commentTemplateIds).')',
            ],
            'fl' => 'id,pid,template_id,cid,cdate,content',
            'strictSort' => 'cdate desc',
            'rows' => $limit,
        ];

        if (!empty($p['beforeId']) && is_numeric($p['beforeId'])) {
            $params['fq'][] = 'id:[* TO '.($p['beforeId'] - 1).']';
        }

        $s = new \Casebox\CoreBundle\Service\Search();
        $sr = $s->query($params);

        if (empty($p['beforeId'])) {
            $rez['total'] = $sr['total'];
        }

        foreach ($sr['data'] as $d) {
            $d['cdate_text'] = Util\formatAgoTime($d['cdate']);
            $d['user'] = User::getDisplayName($d['cid'], true);

            // Data in solr has already encoded html special chars
            // So we need to decode it and to format the message (where the chars will be encoded again)
            $d['content'] = htmlspecialchars_decode($d['content'], ENT_COMPAT);
            $d['content'] = Object::processAndFormatMessage($d['content']);

            array_unshift($rez['data'], $d);
        }

        static::addAttachmentLinks($rez);

        return $rez;
    }

    /**
     * Load a single comment by id
     * used for add/update operations on comments
     *
     * @param int $id
     *
     * @return array response
     */
    public static function loadComment($id)
    {
        $rez = [
            'success' => true,
            'data' => [],
        ];

        if (empty($id)) {
            return $rez;
        }

        $params = [
            'system' => '[0 TO 2]',
            'fq' => [
                'id:'.intval($id),
            ],
            'fl' => 'id,pid,template_id,cid,cdate,content',
            'rows' => 1,
        ];

        $s = new \Casebox\CoreBundle\Service\Search();
        $sr = $s->query($params);

        foreach ($sr['data'] as $d) {
            $d['cdate_text'] = Util\formatAgoTime($d['cdate']);
            $d['user'] = User::getDisplayName($d['cid'], true);

            // Data in solr has already encoded html special chars
            // so we need to decode it and to format the message (where the chars will be encoded again)
            $d['content'] = htmlspecialchars_decode($d['content'], ENT_COMPAT);
            $d['content'] = Object::processAndFormatMessage($d['content']);

            array_unshift($rez['data'], $d);
        }

        static::addAttachmentLinks($rez);

        return @array_shift($rez['data']);
    }

    /**
     * Add attachment links below the comments body
     *
     * @param array $rez
     *
     * @return void
     */
    protected static function addAttachmentLinks(&$rez)
    {
        //collect comment ids
        $ids = [];

        foreach ($rez['data'] as $d) {
            $ids[] = $d['id'];
        }

        if (empty($ids)) {
            return;
        }

        // Select files for all loaded comments using a single solr request
        $params = [
            'system' => '[0 TO 2]',
            'fq' => [
                'pid:('.implode(' OR ', $ids).')',
                'template_type:"file"',
            ],
            'fl' => 'id,pid,name,template_id',
            'sort' => 'pid,cdate',
            'rows' => 50,
            'dir' => 'asc',
        ];

        $s = new Search();
        $sr = $s->query($params);

        $files = [];
        $fileIds = [];
        $fileTypes = [];

        foreach ($sr['data'] as $d) {
            $files[$d['pid']][] = $d;
            $fileIds[] = $d['id'];
        }

        // Get file types
        if (!empty($fileIds)) {
            $fileTypes = DM\Files::getTypes($fileIds);
        }

        foreach ($rez['data'] as &$d) {
            if (empty($files[$d['id']])) {
                continue;
            }

            $links = [];
            foreach ($files[$d['id']] as $f) {
                $f['type'] = @$fileTypes[$f['id']];
                $links[] = static::getFileLink($f);
            }

            $d['files'] = '<ul class="comment-attachments"><li>'.implode('</li><li>', $links).'</li></ul>';
        }
    }

    /**
     * Get link to a file to be displayed in comments
     *
     * @param  array $file
     *
     * @return string
     */
    protected static function getFileLink($file)
    {
        if (substr($file['type'], 0, 5) == 'image') {
            $rez = '<a class="click obj-ref" itemid="'.$file['id'].
                '" templateid= "'.$file['template_id'].
                '" title="'.$file['name'].
                '"><img class="fit-img" src="/c/'.Config::get('core_name').'/download/'.$file['id'].'/" /></a>';

        } else {
            $rez = '<a class="click obj-ref icon-padding '.Files::getIcon($file['name']).'" itemid="'.$file['id'].
                '" templateid= "'.$file['template_id'].
                '">'.$file['name'].'</a>';
        }

        return $rez;
    }
}
