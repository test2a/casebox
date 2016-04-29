<?php
namespace Casebox\CoreBundle\EventListener;

use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\System;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\DependencyInjection\Container;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;

/**
 * Class RequestListener
 */
class RequestListener
{
    /**
     * @var Container
     */
    private $container;

    /**
     * RequestListener constructor
     */
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    /**
     * @param GetResponseEvent $event
     */
    public function onKernelRequest(GetResponseEvent $event)
    {
        if (!$event->isMasterRequest()) {
            return;
        }

        // Bootstrap casebox application settings
        $system = new System();
        $system->bootstrap($this->container, $event->getRequest());

        // Handle environment switching
        $env = $this->container->getParameter('kernel.environment');
        $token = $this->container->get('security.token_storage')->getToken();

        if ($token instanceof UsernamePasswordToken) {
            $provider = $token->getProviderKey();
            if ($provider != $env) {
                $this->container->get('casebox_core.service_auth.authentication')->logout();

                $parameters = [
                    'projectName' => $this->container->get('casebox_core.service.config')->getProjectName(),
                    'coreName' => $env,
                ];
                $url = $this->container->get('router')->generate('app_core_login', $parameters);

                return new RedirectResponse($url);
            }
        }
    }
}
