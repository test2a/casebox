<?php

namespace Casebox\CoreBundle\Service\Test;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ConnectException;

/**
 * Class CaseboxRpcTestService
 */
class CaseboxRpcTestService extends \PHPUnit_Framework_TestCase
{
    const CORE_NAME = 'test';
    const USER_NAME = 'root';
    const USER_PASS = 'a';

    /**
     * @var Client
     */
    protected $client;

    /**
     * @inheritdoc
     */
    public function __construct($name = null, array $data = [], $dataName = '')
    {
        parent::__construct($name, $data, $dataName);

        $this->client = $this->getClient();
    }

    /**
     * @inheritdoc
     */
    function __destruct()
    {
        // Logout
        $this->logout();
    }

    /**
     * @param string $schema
     * @param string $host
     * @param integer $port
     *
     * @return Client
     */
    protected function getClient($schema = 'http', $host = '127.0.0.1', $port = 8080)
    {
        try {
            $client = new Client(
                [
                    'base_uri' => $schema.'://'.$host.':'.$port.'/',
                    'timeout' => 0,
                    'cookies' => true,
                    'exceptions' => false,
                    'allow_redirects' => [
                        'max' => 3,
                        'strict' => true,
                        'referer' => true,
                        'protocols' => ['http'],
                    ],
                ]
            );
        } catch (ConnectException $e) {
            throw new \Exception($e->getMessage());
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }

        return $client;
    }

    /**
     * Login
     * @return string|\Psr\Http\Message\ResponseInterface
     */
    public function login()
    {
        $params = [
            'form_params' => [
                'u' => self::USER_NAME,
                'p' => self::USER_PASS,
                's' => 'Login',
            ],
        ];

        return $this->client->request('POST', '/c/'.self::CORE_NAME.'/login/auth', $params);
    }

    /**
     * Logout
     * @return string|\Psr\Http\Message\ResponseInterface
     */
    public function logout()
    {
        return $this->client->get('/c/'.self::CORE_NAME.'/logout', []);
    }
}
