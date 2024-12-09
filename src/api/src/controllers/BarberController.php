<?php

namespace App\controllers;

use App\DataAccess\DataAccess;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class BarberController extends DataAccess
{
    public function getBarbers(Request $request, Response $response, $args): Response
    {
        $result['rows'] = $this->get('barbers');

        $response->getBody()->write(json_encode($result));

        return $response
            ->withHeader('Content-Type', 'application/json');
    }
}