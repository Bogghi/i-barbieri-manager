<?php

namespace App\controllers;

use App\DataAccess\DataAccess;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class AuthController extends DataAccess

{
    private const array JWT_HEADER = ['alg' => 'HS256', 'typ' => 'jwt'];

    private function base64URLEncode(string $text): string
    {

        return str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($text));
    }
    private function generateToken(array $payload): String
    {
        $bs64header = $this->base64URLEncode(json_encode(self::JWT_HEADER));
        $bs64payload = $this->base64URLEncode(json_encode($payload));
        $signature = hash_hmac("sha256", $bs64header . "." . $bs64payload, JWT_SECRET, true);
        $bs64signature = $this->base64URLEncode($signature);

        return "$bs64header.$bs64payload.$bs64signature";
    }

    public function login(Request $request, Response $response, $args): Response
    {
        $result = [];
        $body = $request->getParsedBody();

        $userData = $this->get(table: 'barber_users', args: ['email' => $body['email']]);

        if($userData && password_verify($body['password'], $userData[0]['password'])) {
            $barberUserId = $userData[0]['barber_user_id'];

            $barberUserTokens = $this->get("oauth_tokens", ['barber_user_id' => $barberUserId, 'expire_date' => '<now()']);
            $barberRefreshTokens = $this->get("refresh_tokens", ['barber_user_id' => $barberUserId, 'expire_date' => '<now()']);
            if(count($barberUserTokens) > 0 && strtotime($barberUserTokens[0]['expire_date']) > strtotime('now')){
                $result['oauth_token'] = $barberUserTokens[0]['oauth_token'];
                $result['refresh_token'] = $barberRefreshTokens[0]['refresh_token'];
            }
            else {
                $expireDateTimestamp = strtotime('+24 hours');
                $expireDateFormatted = date('Y-m-d H:i:s', $expireDateTimestamp);
                $oAuthToken = $this->generateToken([
                    'email' => $userData[0]['email'],
                    'password' => $userData[0]['password'],
                    'eat' => $expireDateTimestamp
                ]);
                $refreshTokenData = $this->generateRefreshToken($userData[0]['barber_user_id']);

                try {
                    $this->debug = true;
                    $this->add(
                        'oauth_tokens',
                        [
                            'oauth_token' => $oAuthToken,
                            'barber_user_id' => $barberUserId,
                            'expire_date' => $expireDateFormatted
                        ]
                    );
                    $this->add(
                        'refresh_tokens',
                        [
                            'refresh_token' => $refreshTokenData['refresh_token'],
                            'barber_user_id' => $barberUserId,
                            'expire_date' => date('Y-m-d H:i:s', $refreshTokenData['expire'])
                        ]
                    );
                    $result['oauth_token'] = $oAuthToken;
                    $result['refresh_token'] = $refreshTokenData['refresh_token'];
                }
                catch (\Exception $e) {
                    $this->status = 403;
                    $result = self::NOT_AUTHORIZED_MESSAGE;
                }
            }
        }
        else {
            $this->status = 403;
            $result = self::NOT_AUTHORIZED_MESSAGE;
        }


        return $this->prepareResponse($response, $result);
    }

    private function generateRefreshToken(int $userId): array
    {
        $res = ['expire' => strtotime('+24 hours')];
        $res['refresh_token'] = $this->generateToken([
            'userId' => $userId,
            'eat' => $res['expire'],
            'refresh_secret' => JWT_SECRET_REFRESH
        ]);

        return $res;
    }

    public function signup(Request $request, Response $response, $args): Response
    {
        $requestBody = $request->getParsedBody();

        if(isset($requestBody['email']) && isset($requestBody['password'])) {

            $userData = $this->get(table: 'barber_users', args: ['email' => $requestBody['email']]);

            if(!$userData) {
                $password = password_hash($requestBody['password'], PASSWORD_DEFAULT);

                $this->add('barber_users', ['email' => $requestBody['email'], 'password' => $password]);
                $body = ['result' => 'OK'];

            }
            else {
                $body = self::NOT_AUTHORIZED_MESSAGE;
            }

        }
        else {
            $this->status = 403;
            $body = self::NOT_AUTHORIZED_MESSAGE;
        }


        return $this->prepareResponse($response, $body);
    }
}