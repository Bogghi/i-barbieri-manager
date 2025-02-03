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

        return $bs64header.$bs64payload.$bs64signature;
    }

    public function login(Request $request, Response $response, $args): Response
    {
        $result = [];
        $body = $request->getParsedBody();

        $userData = $this->get(table: 'barber_users', args: ['email' => $body['email']]);

        if($userData && password_verify($body['password'], $userData[0]['password'])) {
            $barberUserId = $userData[0]['barber_user_id'];

            $barberUserTokens = $this->get("jwt_tokens", ['barber_user_id' => $barberUserId]);
            if(count($barberUserTokens) > 0 && strtotime($barberUserTokens[0]['expire_date']) > strtotime('now')){
                $result['token'] = $barberUserTokens[0]['jwt_token'];
            }
            else {
                $expireDateTimestamp = strtotime('+24 hours');
                $expireDateFormatted = date('Y-m-d H:i:s', $expireDateTimestamp);
                $token = $this->generateToken([
                    'email' => $userData[0]['email'],
                    'password' => $userData[0]['password'],
                    'eat' => $expireDateTimestamp
                ]);

                $this->add('jwt_tokens', ['jwt_token' => $token, 'barber_user_id' => $barberUserId, 'expire_date' => $expireDateFormatted]);

                $result['token'] = $token;
            }
        }else {
            $this->status = 403;
            $result = self::NOT_AUTHORIZED_MESSAGE;
        }

        $response->getBody()->write(json_encode($result));
        return $response
            ->withStatus($this->status)
            ->withHeader('Content-type', 'application/json');
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

        $response->getBody()->write(json_encode($body));
        return $response
            ->withStatus($this->status)
            ->withHeader('Content-type', 'application/json');
    }
}