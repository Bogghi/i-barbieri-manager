<?php

namespace App\controllers;

use App\DataAccess\DataAccess;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class BarberStoresController extends DataAccess
{
    public function getStores(Request $request, Response $response, $args): Response
    {
        $result['barberStores'] = $this->get('barber_stores');

        $response->getBody()->write(json_encode($result));

        return $response
            ->withHeader('Content-Type', 'application/json');
    }
}