<?php

namespace Casebox\CoreBundle\Service\Auth;

use Casebox\CoreBundle\Service\Config;

/**
 * Class GoogleAuth
 */
class GoogleAuth implements AuthInterface
{
    const GOOGLE_API_URL = 'https://chart.googleapis.com/chart?chs=200x200&chld=M|0&cht=qr&chl=';

    /**
     * Secret key length used
     * @var int
     */
    private $secretLength = 16;

    /**
     * Secret data
     * @var array|null
     */
    private $secretData = null;

    /**
     * Google authenticator library class instance
     * @var object
     */
    private $instance = null;

    /**
     * @var integer
     */
    protected $_codeLength = 6;

    /**
     * @param array $p
     * @param string|null $data
     */
    public function __construct($p = [], $data = null)
    {
        if (isset($p['secretLength']) && is_numeric($p['secretLength'])) {
            $this->secretLength = $p['secretLength'];
        }
        if (!empty($data)) {
            $this->secretData = $data;
        }
    }

    /**
     * Method for preparing secret data creation.
     * For example google authenticator will generate secret key
     * @return array associative array of secret params
     */
    public function prepareSecretDataCreation()
    {
        return ['sk' => $this->createSecret($this->secretLength)];
    }

    /**
     * Create secret data
     *
     * @param array|string|null $params
     *
     * @return string|array Secret data
     */
    public function createSecretData($params = null)
    {
        return $params;
    }

    /**
     * Set secret params
     *
     * @param string $secretData secret data used for code generation
     *
     * @return void
     */
    public function setSecretData($secretData)
    {
        $this->secretData = $secretData;
    }

    /**
     * return the secret params
     * @return array|string
     */
    public function getSecretData()
    {
        return $this->secretData;
    }

    /**
     * Function to return data used for message displayed to user when enabling TSV.
     * @return array
     */
    public function getTemplateData()
    {
        $key = $this->secretData['sk'];
        $spacedKey = '';
        while (!empty($key)) {
            $spacedKey .= substr($key, 0, 4).' ';
            $key = substr($key, 4);
        }

        $result = [
            'sd' => $spacedKey,
            'url' => $this->getQRCodeGoogleUrl(Config::get('core_url'), $this->secretData['sk']),
        ];

        return $result;
    }

    /**
     * Return a generated code (otp). Used by Google Authenticatot for sending the code over sms.
     * @return string
     */
    public function getCode()
    {
        return $this->_getCode($this->secretData['sk']);
    }

    /**
     * Verify a given code
     *
     * @param string $code one tyme password
     *
     * @return bool
     */
    public function verifyCode($code)
    {
        return $this->_verifyCode($this->secretData['sk'], $code);
    }

    /**
     * Create new secret.
     * 16 characters, randomly chosen from the allowed base32 characters.
     *
     * @param int $secretLength
     *
     * @return string
     */
    public function createSecret($secretLength = 16)
    {
        $validChars = $this->_getBase32LookupTable();
        unset($validChars[32]);

        $secret = '';
        for ($i = 0; $i < $secretLength; $i++) {
            $secret .= $validChars[array_rand($validChars)];
        }

        return $secret;
    }

    /**
     * Get QR-Code URL for image, from google charts
     *
     * @param string $name
     * @param string $secret
     * @param string $title
     *
     * @return string
     */
    public function getQRCodeGoogleUrl($name, $secret, $title = null)
    {
        $urlencoded = urlencode('otpauth://totp/'.$name.'?secret='.$secret.'');
        if (isset($title)) {
            $urlencoded .= urlencode('&issuer='.urlencode($title));
        }

        return self::GOOGLE_API_URL.$urlencoded.'';
    }

    /**
     * Set the code length, should be >=6
     *
     * @param int $length
     *
     * @return $this
     */
    public function setCodeLength($length)
    {
        $this->_codeLength = $length;

        return $this;
    }

    /**
     * Calculate the code, with given secret and point in time
     *
     * @param string $secret
     * @param int|null $timeSlice
     *
     * @return string
     */
    protected function _getCode($secret, $timeSlice = null)
    {
        if ($timeSlice === null) {
            $timeSlice = floor(time() / 30);
        }

        $secretkey = $this->_base32Decode($secret);

        // Pack time into binary string
        $time = chr(0).chr(0).chr(0).chr(0).pack('N*', $timeSlice);
        // Hash it with users secret key
        $hm = hash_hmac('SHA1', $time, $secretkey, true);
        // Use last nipple of result as index/offset
        $offset = ord(substr($hm, -1)) & 0x0F;
        // grab 4 bytes of the result
        $hashpart = substr($hm, $offset, 4);

        // Unpak binary value
        $value = unpack('N', $hashpart);
        $value = $value[1];
        // Only 32 bits
        $value = $value & 0x7FFFFFFF;

        $modulo = pow(10, $this->_codeLength);

        return str_pad($value % $modulo, $this->_codeLength, '0', STR_PAD_LEFT);
    }

    /**
     * Check if the code is correct. This will accept codes starting from $discrepancy*30sec ago to $discrepancy*30sec
     * from now
     *
     * @param string $secret
     * @param string $code
     * @param int $discrepancy This is the allowed time drift in 30 second units (8 means 4 minutes before or after)
     * @param int|null $currentTimeSlice time slice if we want use other that time()
     *
     * @return bool
     */
    protected function _verifyCode($secret, $code, $discrepancy = 1, $currentTimeSlice = null)
    {
        if ($currentTimeSlice === null) {
            $currentTimeSlice = floor(time() / 30);
        }

        for ($i = -$discrepancy; $i <= $discrepancy; $i++) {
            $calculatedCode = $this->_getCode($secret, $currentTimeSlice + $i);
            if ($calculatedCode == $code) {
                return true;
            }
        }

        return false;
    }

    /**
     * Helper class to decode base32
     *
     * @param $secret
     *
     * @return bool|string
     */
    protected function _base32Decode($secret)
    {
        if (empty($secret)) {
            return '';
        }

        $base32chars = $this->_getBase32LookupTable();
        $base32charsFlipped = array_flip($base32chars);

        $paddingCharCount = substr_count($secret, $base32chars[32]);
        $allowedValues = [6, 4, 3, 1, 0];
        if (!in_array($paddingCharCount, $allowedValues)) {
            return false;
        }
        for ($i = 0; $i < 4; $i++) {
            if ($paddingCharCount == $allowedValues[$i] &&
                substr($secret, -($allowedValues[$i])) != str_repeat($base32chars[32], $allowedValues[$i])
            ) {
                return false;
            }
        }
        $secret = str_replace('=', '', $secret);
        $secret = str_split($secret);
        $binaryString = "";
        for ($i = 0; $i < count($secret); $i = $i + 8) {
            $x = "";
            if (!in_array($secret[$i], $base32chars)) {
                return false;
            }
            for ($j = 0; $j < 8; $j++) {
                $x .= str_pad(base_convert(@$base32charsFlipped[@$secret[$i + $j]], 10, 2), 5, '0', STR_PAD_LEFT);
            }
            $eightBits = str_split($x, 8);
            for ($z = 0; $z < count($eightBits); $z++) {
                $binaryString .= (($y = chr(base_convert($eightBits[$z], 2, 10))) || ord($y) == 48) ? $y : "";
            }
        }

        return $binaryString;
    }

    /**
     * Helper class to encode base32
     *
     * @param string $secret
     * @param bool $padding
     *
     * @return string
     */
    protected function _base32Encode($secret, $padding = true)
    {
        if (empty($secret)) {
            return '';
        }

        $base32chars = $this->_getBase32LookupTable();

        $secret = str_split($secret);
        $binaryString = "";
        for ($i = 0; $i < count($secret); $i++) {
            $binaryString .= str_pad(base_convert(ord($secret[$i]), 10, 2), 8, '0', STR_PAD_LEFT);
        }
        $fiveBitBinaryArray = str_split($binaryString, 5);
        $base32 = "";
        $i = 0;
        while ($i < count($fiveBitBinaryArray)) {
            $base32 .= $base32chars[base_convert(str_pad($fiveBitBinaryArray[$i], 5, '0'), 2, 10)];
            $i++;
        }
        if ($padding && ($x = strlen($binaryString) % 40) != 0) {
            if ($x == 8) {
                $base32 .= str_repeat($base32chars[32], 6);
            } elseif ($x == 16) {
                $base32 .= str_repeat($base32chars[32], 4);
            } elseif ($x == 24) {
                $base32 .= str_repeat($base32chars[32], 3);
            } elseif ($x == 32) {
                $base32 .= $base32chars[32];
            }
        }

        return $base32;
    }

    /**
     * Get array with all 32 characters for decoding from/encoding to base32
     *
     * @return array
     */
    protected function _getBase32LookupTable()
    {
        return [
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', //  7
            'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', // 15
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', // 23
            'Y', 'Z', '2', '3', '4', '5', '6', '7', // 31
            '='  // padding char
        ];
    }
}
