<?php

namespace Casebox\CoreBundle\Service\Facets;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\Util;
use Casebox\CoreBundle\Traits\TranslatorTrait;

/**
 * Class StringsFacet
 */
class StringsFacet
{
    use TranslatorTrait;

    /**
     * @var array
     */
    protected $config = [];

    protected $solrResultRoot = 'facet_counts';

     /**
     * StringsFacet constructor
     */
    public function __construct($config)
    {
        $this->config = $config;
        $this->field = empty($config['field']) ? $config['name'] : $config['field'];
    }

    /**
     * @return array
     */
    public function getSolrParams()
    {
        $rez = [
            'facet' => true,
            'facet.field' => [
                '{!ex='.$this->field.' key='.$this->config['name'].'}'.$this->field,
            ],
        ];

        if (!empty($this->config['child'])) {
            $domain = empty($this->config['domain'])
                ? ['blockParent' => 'child:false']
                : $this->config['domain'];

            $rez = array(
                'facet' => true
                // ,'requestHandler' => 'bjf'
                ,'json.facet' => [
                    $this->config['name'] => [
                        'type' => 'terms',
                        'field' => $this->field,
                        'domain' => $domain
                    ]
                ]
            );
        }

        return $rez;
    }

    /**
     * @param array $p
     *
     * @return array
     */
    public function getFilters(&$p)
    {
        $rez = [];
        if (!empty($p['filters'][$this->field])) {
            $conditions = [];
            $v = $p['filters'][$this->field];
            for ($i = 0; $i < sizeof($v); $i++) {
                if (!empty($v[$i]['values'])) {
                    $conditions[] = '{!tag='.$this->field.'}'.
                        $this->field.':('.implode(' '.$v[$i]['mode'].' ', $v[$i]['values']).')';
                }
            }

            $rez['fq'][] = implode(' AND ', $conditions);
        }

        return $rez;
    }

    /**
     * @param $solrResult
     */
    public function loadSolrResult($solrResult)
    {
        $this->solrData = [];
        $index = $this->config['name'];
        if (!empty($this->config['child'])) {
            $this->solrResultRoot = 'facets';
        }

        //detect facet results
        $sr = null;
        if (!empty($solrResult->{$this->solrResultRoot})) {
            $sr = &$solrResult->{$this->solrResultRoot};
        } elseif (!empty($solrResult->facets)) {
            $sr = &$solrResult->facets;
        }

        if (!empty($sr)) {
            if (empty($this->config['child'])) {
                if (!empty($sr->facet_fields->$index)) {
                    $this->solrData = $sr->facet_fields->$index;
                }
            } elseif (!empty($sr->$index)) {
                $data = (array) $sr->$index;
                if (!empty($data['buckets'])) {
                    foreach ($data['buckets'] as $k => $v) {
                        $this->solrData[$v->val] = $v->count;
                    }
                }
            }
        }
    }

    /**
     * @return bool|float|int|string
     */
    public function getTitle()
    {
        $rez = 'Facet';

        $configService = Cache::get('symfony.container')->get('casebox_core.service.config');

        $coreLanguage = $configService->get('language');
        $userLanguage = $configService->get('user_language');

        if (!empty($this->config['title'])) {
            $t = &$this->config['title'];
            if (is_scalar($t)) {
                $rez = $t;
                if ($t[0] == '[') {
                    $rez = $this->trans(substr($t, 1, strlen($t) - 2));
                    if (empty($rez)) {
                        $rez = $t;
                    }
                }
            } elseif (!empty($t[$userLanguage])) {
                $rez = $t[$userLanguage];
            } elseif (!empty($t[$coreLanguage])) {
                $rez = $t[$coreLanguage];
            }
        }

        return $rez;
    }

    /**
     * Get sort options from config
     *
     * @param string $defaultDirection Default direction to use if not specified in config
     * @param string $defaultType      Default type to use if not specified in config
     *
     * @return array|null
     */
    protected function getSortParams($defaultDirection = 'asc', $defaultType = 'asString')
    {
        $rez = null;
        $cfg = &$this->config;

        if (!empty($cfg['sort'])) {
            if (is_array($cfg['sort'])) {
                $rez = $cfg['sort'];

                if (empty($rez['direction'])) {
                    $rez['direction'] = $defaultDirection;
                }

                if (empty($rez['type'])) {
                    $rez['type'] = $defaultType;
                }

            } else {
                $parts = Util\toTrimmedArray($cfg['sort'], ' ');
                $rez = [
                    'property' => $parts[0],
                    'direction' => empty($parts[1]) ? $defaultDirection : $parts[1],
                    'type' => empty($parts[2]) ? $defaultType : $parts[2],
                ];
            }
        }

        return $rez;
    }

    /**
     * @param array $options
     *
     * @return array
     */
    public function getClientData($options = [])
    {
        $options = $options; // Dummy Codacy assignment
        $rez = [
            'f' => $this->field,
            'title' => $this->getTitle(),
            'items' => $this->solrData,
        ];

        // Check if have default sorting set in cofig
        if (!empty($this->config['sort'])) {
            // Convert items to suitable sortable array
            $rez['items'] = [];
            foreach ($this->solrData as $k => $v) {
                $rez['items'][$k] = [
                    'name' => $k,
                    'count' => $v,
                ];
            }

            $sp = $this->getSortParams();

            Util\sortRecordsArray(
                $rez['items'],
                $sp['property'],
                $sp['direction'],
                $sp['type'],
                true
            );

            // Add sort param for client side
            $rez['sort'] = $sp;
        }

        return $rez;
    }
}
