<?php
namespace Casebox\CoreBundle\Controller;

use Casebox\CoreBundle\Entity\UsersGroups;
use Casebox\CoreBundle\Service\Config;
use Casebox\CoreBundle\Service\User;
use FOS\RestBundle\Controller\Annotations\QueryParam;
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
        $vars = [
            'projectName' => Config::getProjectName(),
            'coreName' => $coreName,
        ];

        if ($request->isMethod(Request::METHOD_POST)) {
            if (empty($request->get('u')) && empty($request->get('e'))) {
                $this->addFlash('notice', $this->get('translator')->trans('Specify_username'));

                return $this->redirectToRoute('app_core_recovery', ['coreName' => $coreName]);    
            }

            if (!empty($request->get('u'))) {
                $user = $this->getDoctrine()->getRepository('CaseboxCoreBundle:UsersGroups')->findUserByUsername($request->get('u'));
                if (!$user instanceof UsersGroups) {
                    $this->addFlash('notice', $this->get('translator')->trans('Specify_username'));

                    return $this->redirectToRoute('app_core_recovery', ['coreName' => $coreName]);
                } 
            }
            
            if (!empty($request->get('e'))) {
                $user = $this->getDoctrine()->getRepository('CaseboxCoreBundle:UsersGroups')->findUserByUsername($request->get('e'));
                if (!$user instanceof UsersGroups) {
                    $this->addFlash('notice', $this->get('translator')->trans('EnterEmail'));

                    return $this->redirectToRoute('app_core_recovery', ['coreName' => $coreName]);
                }
            }
            
            $this->get('casebox_core.service.users_groups')->sendResetPasswordMail($user->getId(), 'recover');

            return $this->render('CaseboxCoreBundle::reset-password.html.twig', $vars);
        }

        return $this->render('CaseboxCoreBundle:forms:forgot-password.html.twig', $vars);
    }


    /**
     * @Route("/c/{coreName}/recover/reset-password", name="app_core_reset")
     * @QueryParam(name="h", nullable=true)
     * @Method({"GET", "POST"})
     * @param Request $request
     * @param string $coreName
     *
     * @return Response
     */
    public function resetAction(Request $request, $coreName)
    {
        $vars = [
            'projectName' => Config::getProjectName(),
            'coreName' => $coreName,
        ];

        $vars['token'] = $request->get('token');

        if (empty($vars['token'])) {
            $this->addFlash('notice', $this->get('translator')->trans('RecoverHashNotFound'));

            return $this->redirectToRoute('app_core_recovery', $vars);
        }

        if ($request->isMethod(Request::METHOD_POST)) {
            // Find user by this $hash
            $user = $this->getDoctrine()
                ->getRepository('CaseboxCoreBundle:UsersGroups')
                ->findOneBy(['recoverHash' => $request->get('token')]);

            if (!$user instanceof UsersGroups) {
                $this->addFlash('notice', $this->get('translator')->trans('RecoverHashNotFound'));

                return $this->redirectToRoute('app_core_recovery', ['coreName' => $coreName]);
            }

            if (empty($request->get('p')) && empty($request->get('p2'))) {
                $this->addFlash('notice', $this->get('translator')->trans('PasswordMissmatch'));

                return $this->redirectToRoute('app_core_reset', $vars);
            }

            if ($request->get('p') != $request->get('p2')) {
                $this->addFlash('notice', $this->get('translator')->trans('PasswordMissmatch'));

                return $this->redirectToRoute('app_core_reset', $vars);
            }

            if (empty($user->getSalt())) {
                $user->setSalt($this->get('casebox_core.service_auth.authentication')->generateSalt());
            }

            // Reset recovery hash
            $user->setRecoverHash(null);
            $this->getDoctrine()->getEntityManager()->flush($user);

            $encPassword = $this->get('casebox_core.service_auth.authentication')
                ->getEncodedPasswordAndSalt($request->get('p2'), $user->getSalt());

            // Update password
            $params = [
                'id' => $user->getId(),
                'password' => $encPassword,
                'confirmpassword' => $encPassword,
            ];

            $result = $this->get('casebox_core.service.users_groups')->changePassword($params, false);
            if ($result['success']) {
                $this->addFlash('success', $this->get('translator')->trans('PasswordChangedMsg'));

                return $this->redirectToRoute('app_core_login', $vars);
            } else {
                $this->addFlash('notice', $this->get('translator')->trans('RecoverHashNotFound'));

                return $this->redirectToRoute('app_core_recovery', $vars);
            }
        }

        return $this->render('CaseboxCoreBundle:forms:reset-password.html.twig', $vars);
    }
}
