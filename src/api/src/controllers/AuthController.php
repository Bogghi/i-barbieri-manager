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
        $result = ['token' => null];
        $body = $request->getParsedBody();

        $userData = $this->get(table: 'barber_user', args: ['email' => $body['email']]);

        if($userData && password_verify($body['password'], $userData[0]['password'])) {
            $result['token'] = $this->generateToken([
                'email' => $userData[0]['email'],
                'password' => $userData[0]['password'],
                'eat' => strtotime('today +24h')
            ]);
        }

        $response->getBody()->write(json_encode($result));
        return $response
            ->withStatus($result['token'] !== null ? 200 : 403)
            ->withHeader('Content-type', 'application/json');
    }
}