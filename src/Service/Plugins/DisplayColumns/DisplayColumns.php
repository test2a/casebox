<?php

namespace Casebox\CoreBundle\Service\Plugins\DisplayColumns;

use Symfony\Component\DependencyInjection\Container;

/**
 * Class DisplayColumnSubscribers
 */
class DisplayColumns
{
    /**
     * @var Container
     */
    protected $container;
    
    /**
     * @param array $p
     */
    public function onBeforeSolrQuery(&$p)
    {
        $ip = &$p['inputParams'];

        if (!empty($ip['from']) && ($ip['from'] == 'tree')) {
            return;
        }

        $className = empty($ip['view']['type']) ? '' : $ip['view']['type'];

        switch ($className) {
            case 'grid':
            case 'activityStream':
            case 'map':
            case 'formEditor':
                break;

            case 'stream':
                $className = 'activityStream';
                break;

            case 'calendar':
                unset($p['params']['sort']);
                break;

            case 'charts':
            case 'pivot':
                //unset sort params for other views
                //because other views (chart, calendar) dont need sorting
                //and would result in error if sorted by a custom column and not processed
                $p['rows'] = 0;
                unset($p['params']['sort']);

                return;
                break;

            default:
                return;
        }
        
        return $this->getPlugin($className)->onBeforeSolrQuery($p);
    }

    /**
     * @param array $p
     */
    public function onSolrQueryWarmUp(&$p)
    {
        $ip = &$p['inputParams'];
        $className = empty($ip['view']['type']) ? '' : $ip['view']['type'];

        switch ($className) {
            case 'grid':
            case 'activityStream':
            case 'formEditor':
                break;

            // don't need to warm up anything, cause location field and title is extracted from solr
            // case 'map':

            default:
                return;
        }

        return $this->getPlugin($className)->onSolrQueryWarmUp($p);
    }

    /**
     * @param array $p
     */
    public function onSolrQuery(&$p)
    {
        $ip = &$p['inputParams'];

        if (!empty($ip['from']) && ($ip['from'] == 'tree')) {
            return;
        }

        $className = empty($ip['view']['type']) ? '' : $ip['view']['type'];

        switch ($className) {
            case 'grid':
            case 'activityStream':
            case 'map':
            case 'formEditor':
            case 'calendar':
                break;

            default:
                return;
        }

        return $this->getPlugin($className)->onSolrQuery($p);
    }

    /**
     * @param string $plugin
     *
     * @return object
     * @throws \Exception
     */
    protected function getPlugin($plugin)
    {
        $serviceId = 'casebox_core.service_plugins_display_columns.'.$plugin;

        if (!$this->container->has($serviceId)) {
            $obj = $this->container->get($serviceId);
        } else {
            $class = __NAMESPACE__.'\\'.ucfirst($plugin);
            $obj = new $class();
        }
        
        return $obj;
    }

    /**
     * @return Container
     */
    public function getContainer()
    {
        return $this->container;
    }

    /**
     * @param Container $container
     *
     * @return DisplayColumns $this
     */
    public function setContainer(Container $container)
    {
        $this->container = $container;

        return $this;
    }
}
