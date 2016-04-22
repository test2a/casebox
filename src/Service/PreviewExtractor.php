<?php

namespace Casebox\CoreBundle\Service;

/**
 * Class PreviewExtractor
 */
class PreviewExtractor
{
    const CONVERTER_API     = 'api';
    const CONVERTER_UNOCONV = 'unoconv';

    const FILE_STATUS_OK         = 0;
    const FILE_STATUS_QUEUE      = 1;
    const FILE_STATUS_PROCESSING = 2;
    const FILE_STATUS_PROCESSED  = 3;

    /**
     * @param integer $id
     */
    public function removeFromQueue($id)
    {
        $dbs = Cache::get('casebox_dbs');

        $dbs->query('DELETE FROM file_previews WHERE id = $1', $id);
    }

    /**
     * @param string $html
     * @param array $options
     *
     * @return mixed|string
     */
    public function purify($html, $options = [])
    {
        if (empty($html)) {
            return '';
        }

        $html = Util\toUTF8String($html);

        $config = \HTMLPurifier_Config::createDefault();
        $config->set('AutoFormat.AutoParagraph', false);
        $config->set('AutoFormat.RemoveEmpty.RemoveNbsp', true);
        //$config->set('AutoFormat.RemoveEmpty', true);//slows down htmls parsing
        //$config->set('AutoFormat.RemoveSpansWithoutAttributes', true); //medium slows down htmls parsing
        $config->set('HTML.ForbiddenElements', ['head']);
        $config->set('HTML.SafeIframe', true);
        $config->set('HTML.TargetBlank', true);
        $config->set('URI.DefaultScheme', 'https');
        $config->set('Attr.EnableID', true);
        if (!empty($options)) {
            foreach ($options as $k => $v) {
                $config->set($k, $v);
            }
        }

        $purifier = new \HTMLPurifier($config);

        // This storage is freed on error
        Cache::set('memory', str_repeat('*', 1024 * 1024));

        //register_shutdown_function([$this, 'onScriptShutdown']);

        $html = $purifier->purify($html);

        Cache::remove('memory');

        $html = str_replace('/preview/#', '#', $html);

        return $html;
    }

    /**
     * Handler
     */
    public static function onScriptShutdown()
    {
        Cache::remove('memory');

        if ((!is_null($err = error_get_last())) && (!in_array($err['type'], [E_NOTICE, E_WARNING]))) {
            $dbs = Cache::get('casebox_dbs');
            $dbs->query('UPDATE file_previews SET `status` = 3 WHERE status = 2');
            $dbs->commitTransaction();
        }
    }

    /**
     * Execute
     */
    public function execute()
    {
        $processing = false;

        $dbs = Cache::get('casebox_dbs');
        $res = $dbs->query('SELECT count(*) `count` FROM file_previews WHERE `status` = 2 AND `group` = $1', 'office');

        if ($r = $res->fetch()) {
            $processing = ($r['count'] > 0);
        }
        unset($res);

        if ($processing) {
            exit(0);
        }

        $filesPreviewDir = Config::get('files_preview_dir');

        $sql = 'SELECT c.id `content_id`, c.path, p.status, (SELECT name FROM files f WHERE f.content_id = c.id LIMIT 1) `name`
                FROM file_previews p
                LEFT JOIN files_content c ON p.id = c.id
                WHERE p.`status` = 1 AND `group` = \'office\'
                ORDER BY p.cdate';

        $res = $dbs->query($sql);

        while ($r = $res->fetch()) {
            // Start the transaction so that the file status would not change on script fail.
            $dbs->startTransaction();

            $dbs->query('UPDATE file_previews SET `status` = 2 WHERE id = $1', $r['content_id']);

            $ext = explode('.', $r['name']);
            $ext = array_pop($ext);
            $ext = strtolower($ext);
            $fn = Config::get('files_dir').$r['path'].DIRECTORY_SEPARATOR.$r['content_id'];
            $nfn = $filesPreviewDir.$r['content_id'].'_.'.$ext;
            $pfn = $filesPreviewDir.$r['content_id'].'_.html';

            copy($fn, $nfn);
            file_put_contents($pfn, '');

            // Refactoring using ConvertDocument API
            switch (Config::get('converter')) {
                case self::CONVERTER_API:
                    $this->convertDocApiRequest($nfn, $pfn);
                    $returnStatus = null;

                    break;

                case self::CONVERTER_UNOCONV:
                    $cmd = Config::get('convert_doc_unoconv_cmd').' -v -f html -o '.$pfn.' '.$nfn;
                    exec($cmd, $output, $returnStatus);

                    break;
            }

            // We cant delete the file right away because command can execute in background and could take some time.
            // unlink($nfn);

            if (empty($returnStatus) && file_exists($pfn)) {
                $params = [
                    'URI.Base' => '/'.Config::get('core_name').'/view/',
                    'URI.MakeAbsolute' => true,
                ];

                $content = '<div style="padding: 5px">'.$this->purify(file_get_contents($pfn), $params).'</div>';
                
                file_put_contents($pfn, $content);

                $params = [
                    $r['content_id'],
                    $r['content_id'].'_.html',
                    filesize($pfn),
                ];

                $dbs->query('UPDATE file_previews SET `status` = 0,`filename` = $2,`size` = $3 WHERE id = $1', $params);
                unset($res);
            } else {
                // Preview not generated for some reason, probably unoconv service not started
                $log = Cache::get('symfony.container')->get('logger');
                $log->pushHandler(Cache::get('symfony.container')->get('monolog.handler.nested'));
                $log->addError('UNOCONV execution error, please check if python accessible through command line.');

                $dbs->query('UPDATE file_previews SET `status` = 3 WHERE id = $1', $r['content_id']);
            }

            $dbs->commitTransaction();

            $res = $dbs->query($sql);
        }

        unset($res);
    }

    /**
     * @param string $destination
     * @param string $source
     *
     * @return string
     * @throws \Exception
     */
    public function convertDocApiRequest($source, $destination)
    {
        $fields = [
            'format' => 'html',
            'file' => curl_file_create($source, mime_content_type($source)),
        ];

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, Config::get('convert_doc_url'));
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

        $result = curl_exec($ch);

        curl_close($ch);

        $data = json_decode($result, true);
        if (is_array($data) && !empty($data['code']) && $data['code'] != 200) {
            throw new \Exception($data['message'], $data['code']);
        }

        if (!empty($result)) {
            file_put_contents($destination, $result);
        }

        return $result;
    }
}
