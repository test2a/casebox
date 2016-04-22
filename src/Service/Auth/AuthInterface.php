<?php

namespace Casebox\CoreBundle\Service\Auth;

/**
 * Interface AuthInterface
 *
 * Auth interface for distinct authentication mechannisms like Google Authenticator, Ybikey
 */
interface AuthInterface
{
    /**
     * Method for preparing secret data creation
     * For example google authenticator will generate secret key
     * $params {
     *     email
     *     code
     * }
     * @return array associative array of secret params
     */
    public function prepareSecretDataCreation();

    /**
     * Create secret data
     *
     * $params {
     *     email
     *     code
     * }
     * @return array associative array of secret params
     */
    public function createSecretData($params = null);

    /**
     * set secret params
     *
     * @param string $secretData Secret data used for code generation
     *
     * @return void
     */
    public function setSecretData($secretData);

    /**
     * Return the secret params
     *
     * @return string|array
     */
    public function getSecretData();

    /**
     * Method for returning data used for message displaying to user when enabling TSV.
     *
     * @param string $secretData Secret data used for code generation
     *
     * @return array
     */
    public function getTemplateData();

    /**
     * Return a generated code (otp). Used by Google Authenticatot for sending the code over sms.
     *
     * @param string $secretData Secret data used for code generation
     *
     * @return string
     */
    public function getCode();

    /**
     * Verify a given code
     *
     * @param  string $code one tyme password
     *
     * @return bool
     */
    public function verifyCode($code);
}
