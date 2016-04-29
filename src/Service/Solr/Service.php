<?php
namespace Casebox\CoreBundle\Service\Solr;

use Casebox\CoreBundle\Event\BeforeNodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\BeforeSolrCommitEvent;
use Casebox\CoreBundle\Event\NodeSolrUpdateEvent;
use Casebox\CoreBundle\Event\SolrCommitEvent;
use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;
use Symfony\Component\EventDispatcher\EventDispatcher;

/**
 * Class Service
 *
 * Solr service class that manages communication between CaseBox and Solr service
 * This class only manages connection and standart calls to Solr service
 */
class Service
{
    /**
     * @type \Apache_Solr_Service solr handler to Solr Service.
     */
    private $solr_handler = null;

    /**
     * @type string solr host.
     */
    private $host = null;

    /**
     * @type string solr port.
     */
    private $port = null;

    /**
     * @type string|null Solr core.
     */
    private $core = null;

    /**
     * @var string|null
     */
    protected $username = null;

    /**
     * @var string|null
     */
    protected $password = null;

    /**
     * @fireEvents
     */
    private $fireEvents = true;

    /**
     * constructor
     *
     * @param string[] $p {
     *
     * @type boolean $host custom Solr host or default will be used from config
     * @type string $port Solr port
     * @type string $core Solr core
     * }
     */
    public function __construct($p = [])
    {
        $this->configService = Cache::get('symfony.container')->get('casebox_core.service.config');

        if (empty($p)) {
            // Get params from config
            $this->schema = $this->configService->get('solr_schema', 'http');
            $this->host = $this->configService->get('solr_host', '127.0.0.1');
            $this->port = $this->configService->get('solr_port', 8983);
            $this->core = $this->configService->get('solr_core');
            $this->username = $this->configService->get('solr_username', null);
            $this->password = $this->configService->get('solr_password', null);
        } else {
            // Get params from specified arguments
            $this->schema = empty($p['schema']) ? 'http' : $p['schema'];
            $this->host = empty($p['host']) ? '127.0.0.1' : $p['host'];
            $this->port = empty($p['port']) ? 8983 : $p['port'];
            $this->core = @$p['core'];
            $this->username = (!empty($p['username'])) ? $p['username'] : null;
            $this->password = (!empty($p['password'])) ? $p['password'] : null;

            if (isset($p['fireEvents'])) {
                $this->fireEvents = $p['fireEvents'];
            }
        }

        if (substr($this->core, 0, 6) != '/solr/') {
            $this->core = '/solr/'.$this->core;
        }

        $this->connect();
    }

    /**
     * Connect to Solr service
     *
     * @return \Apache_Solr_Service handler to solr intance
     * @throws \Exception
     */
    public function connect()
    {
        if (!empty($this->solr_handler)) {
            return $this->solr_handler;
        }

        $cacheCoreName = 'solr_service_'.$this->core;
        $this->solr_handler = Cache::get($cacheCoreName);

        if (empty($this->solr_handler)) {
            $layer = new \Apache_Solr_Compatibility_Solr4CompatibilityLayer;
            $this->solr_handler = new ServiceHandler(
                $this->host,
                $this->port,
                $this->core,
                false,
                $layer
            );

            if (!empty($this->username) && !empty($this->password)) {
                $this->solr_handler->setAuthenticationCredentials($this->username, $this->password);
            }

            if (!$this->solr_handler->ping()) {
                throw new \Exception('Solr_connection_error'.$this->debugInfo(), 1);
            }

            // Setting handler in cache raise errors for atomic updates
            Cache::set($cacheCoreName, $this->solr_handler);
        }

        return $this->solr_handler;
    }

    /**
     * test if service is connected
     * @return boolean
     */
    public function ping()
    {
        return $this->solr_handler->ping();
    }

    /**
     * @return \Apache_Solr_Service
     */
    public function reconnect()
    {
        unset($this->solr_handler);

        return $this->connect();
    }

    /**
     * verify if can connect to solr with given config
     *
     * @param array $cfg (host, port, core, SOLR_CLIENT optional)
     *
     * @return boolean
     */
    public static function verifyConfigConnection($cfg)
    {
        try {
            $rez = new Client($cfg);
        } catch (\Exception $e) {
            $rez = false;
        }

        return $rez;
    }

    /**
     * Add or update a single document into solr
     *
     * @param array $d array of document properties
     *
     * @return bool
     * @throws \Exception
     */
    public function addDocument($d)
    {
        $doc = $this->arrayToSolrDocument($d);

        try {
            /** @var EventDispatcher $dispatcher */
            $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');
            $dispatcher->dispatch('beforeNodeSolrUpdate', new BeforeNodeSolrUpdateEvent($doc));

            $this->solr_handler->addDocument($doc);

            $dispatcher->dispatch('nodeSolrUpdate', new NodeSolrUpdateEvent($doc));
        } catch (\SolrClientException $e) {
            $msg = "Error adding document to solr (id:".$d['id'].')'.$this->debugInfo();
            Cache::get('symfony.container')->get('logger')->error($msg);
            throw new \Exception($msg, 1);
        }

        return true;
    }

    /**
     * updating multiple documents into solr using atomic updates
     *
     * @param array $docs array of documents to be updated into solr
     */
    public function updateDocuments($docs)
    {
        $url = $this->schema.'://'.$this->host.':'.$this->port.$this->core.'/update/json';
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ["Content-type:application/json; charset=utf-8"]);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, Util\jsonEncode(array_values($docs)));
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        curl_setopt($ch, CURLINFO_HEADER_OUT, 1);

        curl_exec($ch);

        if (curl_errno($ch)) {
            throw new \Exception("curl_error:".curl_error($ch).$this->debugInfo(), 1);
        }
    }

    /**
     * adding/updating multiple documents to solr.
     *
     * This function will divide received documents array into two sets of documents
     * those that should be updated by adding them again into solr
     * and other that should be updated via atomic update (if update property is set)
     *
     * @param array $docs array of documents to be indexed into solr
     */
    public function addDocuments(&$docs)
    {
        $addDocs = [];
        $updateDocs = [];

        /** @var EventDispatcher $dispatcher */
        $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');

        foreach ($docs as $in_doc) {
            if (empty($in_doc['update'])) {
                $doc = $this->arrayToSolrDocument($in_doc);

                $dispatcher->dispatch('beforeNodeSolrUpdate', new BeforeNodeSolrUpdateEvent($doc));

                $addDocs[] = $doc;
            } else {
                $doc = [];
                unset($in_doc['update']);
                foreach ($in_doc as $fn => $fv) {
                    if ($fn == 'id') {
                        $doc[$fn] = $fv;
                    } else {
                        $doc[$fn] = ['set' => $fv];
                    }
                }
                $updateDocs[] = $doc;
            }
        }

        try {
            if (!empty($addDocs)) {
                $this->solr_handler->addDocuments($addDocs);
            }
            if (!empty($updateDocs)) {
                $this->updateDocuments($updateDocs);
            }
        } catch (\Exception $e) {
            $msg = "Error adding multiple documents to solr.\n".$e->__toString().$this->debugInfo();
            throw new \Exception($msg, 1);
        }

        /* fire after update events */
        for ($i = 0; $i < sizeof($addDocs); $i++) {
            $dispatcher->dispatch('nodeSolrUpdate', new NodeSolrUpdateEvent($addDocs[$i]));
        }

        for ($i = 0; $i < sizeof($updateDocs); $i++) {
            if ($updateDocs[$i] instanceof \Apache_Solr_Document) {
                $dispatcher->dispatch('nodeSolrUpdate', new NodeSolrUpdateEvent($updateDocs[$i]));
            }
        }

        return true;
    }

    /**
     * @param string $query
     * @param int    $start
     * @param int    $rows
     * @param array  $params
     *
     * @return \Apache_Solr_Response
     * @throws \Apache_Solr_InvalidArgumentException
     */
    public function search($query, $start, $rows, $params)
    {
        return $this->solr_handler->search($query, $start, $rows, $params);
    }

    /**
     * Commit solr updates
     * @return null
     */
    public function commit()
    {
        /** @var EventDispatcher $dispatcher */
        $dispatcher = Cache::get('symfony.container')->get('event_dispatcher');
        $dispatcher->dispatch('onBeforeSolrCommit', new BeforeSolrCommitEvent($this->solr_handler));

        $this->solr_handler->commit();

        $dispatcher->dispatch('onSolrCommit', new SolrCommitEvent($this->solr_handler));
    }

    /**
     * Delete documents from solr by a query
     *
     * @param string $query solr query
     *
     * @throws \Exception
     */
    public function deleteByQuery($query)
    {
        try {
            $this->solr_handler->deleteByQuery($query);
            $this->commit();

        } catch (\Exception $e) {
            $msg = "Cannot delete by query".$this->debugInfo();
            Cache::get('symfony.container')->get('logger')->error($msg);
            throw new \Exception($msg, 1);
        }
    }

    /**
     * Optimize current solr core
     * @return null
     * @throws \Exception
     */
    public function optimize()
    {
        try {
            $this->solr_handler->optimize();
            $this->commit();

        } catch (\Exception $e) {
            $msg = "Cannot optimize solr core".$this->debugInfo();
            Cache::get('symfony.container')->get('logger')->error($msg);
            throw new \Exception($msg, 1);
        }
    }

    private function debugInfo()
    {
        return "\n".' ('.$this->host.':'.$this->port.' -> '.$this->core.' )';
    }

    /**
     * convert an array to solr document class
     *
     * @param array $arr
     *
     * @return \Apache_Solr_Document
     *
     */
    protected function arrayToSolrDocument($arr)
    {
        $rez = new \Apache_Solr_Document();
        $children = empty($arr['_childDocuments_']) ? [] : $arr['_childDocuments_'];
        unset($arr['_childDocuments_']);

        foreach ($arr as $fn => $fv) {
            $rez->$fn = $fv;
        }

        if (!empty($children)) {
            //detect parent only values
            $nonChildValues = $arr;
            $childFields = [];
            foreach ($children as $d) {
                $childFields = array_merge($childFields, array_keys($d));
            }
            $childFields = array_unique($childFields);
            foreach ($childFields as $fn) {
                unset($nonChildValues[$fn]);
            }

            $childDocs = [];
            foreach ($children as $d) {
                // Merge parent properties to children
                $childDocs[] = $this->arrayToSolrDocument(array_merge($nonChildValues, $d));
            }
            $rez->_childDocuments_ = $childDocs;
        }

        return $rez;
    }
}
