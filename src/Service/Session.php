<?php

namespace Casebox\CoreBundle\Service;

use Casebox\CoreBundle\Service\Cache;
use Casebox\CoreBundle\Service\DataModel as DM;

/**
 * Class Session
 */
class Session implements \SessionHandlerInterface
{
    private $lifetime = 0;

    /**
     * Lifetime for previous sessions.
     *
     * We give them a timeout becouse client side can send requests
     * with parent/old session key, until result is received from current executing script.
     *
     * @var integer number of seconds
     */
    private $lifetime_pid_sessions = 3;

    /**
     * On session id regeneration the primary session id is saved in this variable
     * @var string
     */
    private $previous_session_id = null;

    /**
     * Session close
     * @return bool
     */
    public function close()
    {
        $this->gc($this->lifetime);

        // close database-connection
        $dbs = Cache::get('casebox_dbs');
        $rez = $dbs->close();

        return $rez;
    }

    /**
     * Destroy session
     *
     * @param  string $sessionId
     *
     * @return bool
     */
    public function destroy($sessionId)
    {
        $rez = DM\Sessions::delete($sessionId);

        return $rez;
    }

    /**
     * Garbage collector
     *
     * @param string $maxLifetime
     *
     * @return bool
     */
    public function gc($maxLifetime)
    {
        if ($maxLifetime == 0) {
            $maxLifetime = null;
        }

        return DM\Sessions::cleanExpired();
    }

    /**
     * Open session
     *
     * @param string $savePath
     * @param string $name Session name
     *
     * @return bool
     */
    public function open($savePath, $name)
    {
        $this->lifetime = ini_get('session.cookie_lifetime');

        return true;
    }

    /**
     * Read session data
     *
     * @param  string $sessionId
     *
     * @return string
     */
    public function read($sessionId)
    {
        $rez = '';

        $r = DM\Sessions::read($sessionId);
        if (!empty($r)) {
            $rez = $r['data'];
        }

        $this->previous_session_id = $sessionId;

        return $rez;
    }

    /**
     * Write session data
     *
     * @param  string $session_id
     * @param  string $session_data
     *
     * @return bool
     */
    public function write($session_id, $session_data)
    {
        $lifetime = ini_get('session.cookie_lifetime');
        $lifetime = empty($this->lifetime) ? null : $this->lifetime;

        // When updating/creating a new session
        // then parent session and all other child sessions shoould be marked as
        // expiring in corresponding timeout
        if (!empty($this->previous_session_id)) {
            DM\Sessions::updateExpiration($session_id, $this->previous_session_id, $this->lifetime_pid_sessions);
        }

        $rez = DM\Sessions::replace(
            [
                'id' => $session_id,
                'pid' => $this->previous_session_id,
                'lifetime' => $lifetime,
                'user_id' => '0'.@Cache::get('session')->get('user')['id'],
                'data' => $session_data,
            ]
        );

        return $rez;
    }

    /**
     * Clear user sessions
     *
     * @param  int $userId
     *
     * @return boolean
     */
    public static function clearUserSessions($userId)
    {
        if (!Security::canEditUser($userId)) {
            return false;
        }

        DM\Sessions::deleteByUserId($userId);

        return true;
    }
}
