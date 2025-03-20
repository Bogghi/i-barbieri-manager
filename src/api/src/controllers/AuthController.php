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
        $body = json_decode($request->getBody()->__toString(), true);

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
                $oAuthTokenData = $this->generateOAuthToken($userData[0]['email'], $userData[0]['password']);
                $refreshTokenData = $this->generateRefreshToken($userData[0]['barber_user_id']);

                try {
                    $this->debug = true;
                    $this->add(
                        'oauth_tokens',
                        [
                            'oauth_token' => $oAuthTokenData['oauth_token'],
                            'barber_user_id' => $barberUserId,
                            'expire_date' => date('Y-m-d H:i:s', $oAuthTokenData['eta'])
                        ]
                    );
                    $this->add(
                        'refresh_tokens',
                        [
                            'refresh_token' => $refreshTokenData['refresh_token'],
                            'barber_user_id' => $barberUserId,
                            'expire_date' => date('Y-m-d H:i:s', $refreshTokenData['eta'])
                        ]
                    );
                    $result['oauth_token'] = $oAuthTokenData['oauth_token'];
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

    public function loginByRefreshToken(Request $request, Response $response, $args): Response
    {
        $body = array();
        $requestBody = $request->getParsedBody();

        if(isset($requestBody['refresh_token'])) {

            $now = date('Y-m-d H:i:s', strtotime('now'));
            $tokens = $this->get('refresh_tokens', ['refresh_token' => $requestBody['refresh_token'], 'expire_date' => ">$now"]);
            if(count($tokens) > 0) {
                $userData = $this->get('barber_users', ['barber_user_id' => $tokens[0]['barber_user_id']]);
                $oAuthTokenData = $this->generateOAuthToken($userData[0]['email'], $userData[0]['password']);
                $refreshTokenData = $this->generateRefreshToken($userData[0]['barber_user_id']);

                try {
                    $this->debug = true;
                    $this->update(
                        'oauth_tokens',
                        ['oauth_token' => $oAuthTokenData['oauth_token'], 'expire_date' => date('Y-m-d H:i:s', $oAuthTokenData['eta'])],
                        ['barber_user_id' => $userData[0]['barber_user_id']]
                    );
                    $this->update(
                        'refresh_tokens',
                        ['refresh_token' => $refreshTokenData['refresh_token'], 'expire_date' => date('Y-m-d H:i:s', $refreshTokenData['eta'])],
                        ['barber_user_id' => $userData[0]['barber_user_id']]
                    );
                    $body['oauth_token'] = $oAuthTokenData['oauth_token'];
                    $body['refresh_token'] = $refreshTokenData['refresh_token'];
                }
                catch (\Exception $e) {
                    $this->status = 403;
                    $body = self::NOT_AUTHORIZED_MESSAGE;
                }
            }
            else {
                $body = self::INVALID_PARAM_MESSAGE;
                $body[] = $tokens;
            }
        }
        else {
            $this->status = 403;
            $body = self::NOT_AUTHORIZED_MESSAGE;
        }

        return $this->prepareResponse($response, $body);
    }

    private function generateRefreshToken(int $userId): array
    {
        $res = ['eta' => strtotime('+24 hours')];
        $res['refresh_token'] = $this->generateToken([
            'userId' => $userId,
            'eat' => $res['eta'],
            'refresh_secret' => JWT_SECRET_REFRESH
        ]);

        return $res;
    }
    private function generateOAuthToken(string $email, string $password): array
    {
        $map = ['eta' => strtotime('+2 hours')];
        $map['oauth_token'] = $this->generateToken([
            'email' => $email,
            'password' => $password,
            'eat' => $map['eta']
        ]);

        return $map;
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