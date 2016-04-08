<?php
namespace Casebox\CoreBundle\Controller;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;

/**
 * Class AuthController
 */
class AuthController extends Controller
{
    /**
     * @Route(
     *     "/c/{coreName}/login/{action}",
     *     name="app_core_login",
     *     defaults = {"action": "getForm"},
     *     requirements={"coreName": "[a-z0-9_\-]+", "action": "getForm|auth|2step"}
     * )
     * @param Request $request
     * @param string $coreName
     * @param string $action
     * @Method({"GET", "POST"})
     *
     * @return Response
     */
    public function indexAction(Request $request, $coreName, $action)
    {
        $loginService = $this->get('casebox_core.service_auth.authentication');

        $vars = [
            'projectName' => Config::getProjectName(),
            'coreName' => $coreName,
            'action' => $action,
        ];

        switch ($action) {
            case 'auth':
                if (empty($request->get('u'))) {
                    $this->addFlash('notice', $this->get('translator')->trans('Specify_username'));

                    return $this->redirectToRoute('app_core', $vars);
                }

                if (empty($request->get('p'))) {
                    $this->addFlash('notice', $this->get('translator')->trans('Specify_password'));

                    return $this->redirectToRoute('app_core', $vars);
                }

                // Normal auth
                $user = $loginService->authenticate($request->get('u'), $request->get('p'));

                if ($user instanceof UsersGroups) {
                    // Check two step auth
                    $auth = $this->get('casebox_core.service_auth.two_step_auth')->authenticate($user, $request->get('c'));
                    if (is_array($auth)) {
                        $this->get('session')->set('auth', serialize($user));

                        return $this->render('CaseboxCoreBundle:forms:authenticator.html.twig', $vars);
                    }

                    return $this->redirectToRoute('app_core', $vars);
                } else {
                    $this->addFlash('notice', $this->get('translator')->trans('Auth_fail'));

                    return $this->redirectToRoute('app_core', $vars);
                }

                break;

            case '2step':
                $auth = ['TSV' => true];

                if ($request->getMethod() === 'POST') {
                    if (empty($request->get('c'))) {
                        $this->addFlash('notice', $this->get('translator')->trans('EnterCode'));

                        return $this->redirectToRoute('app_core_login', $vars);
                    }

                    $user = unserialize($this->get('session')->get('auth'));
                    $auth = $this->get('casebox_core.service_auth.two_step_auth')->authenticate(
                        $user,
                        $request->get('c')
                    );
                }

                if (is_array($auth)) {
                    $this->addFlash('notice', $auth['message']);

                    return $this->render('CaseboxCoreBundle:forms:authenticator.html.twig', $vars);
                }

                $this->get('session')->remove('auth');

                return $this->redirectToRoute('app_core', $vars);

                break;
        }

        return $this->render('CaseboxCoreBundle:forms:login.html.twig', $vars);
    }

    /**
     * @Route("/c/{coreName}/logout", name="app_core_logout", requirements={"coreName": "[a-z0-9_\-]+"})
     * @param Request $request
     * @param string $coreName
     * @Method({"GET", "POST"})
     *
     * @return Response
     */
    public function logoutAction(Request $request, $coreName)
    {
        $this->get('casebox_core.service_auth.authentication')->logout();

        return $this->redirectToRoute('app_core_login', ['coreName' => $coreName]);
    }

    /**
     * @Route("/c/{coreName}/recover/forgot-password", name="app_core_recovery")
     * @Method({"GET", "POST"})
     * @param Request $request
     * @param string $coreName
     *
     * @return Response
     */
    public function recoveryAction(Request $request, $coreName)
    {
        // @todo - Fix this page
        $this->addFlash('warning', 'Password recovery is not available yet.');

        return $this->redirectToRoute('app_core_login', ['coreName' => $coreName]);
    }
}
