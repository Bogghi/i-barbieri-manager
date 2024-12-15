<?php

namespace App\controllers;

use App\DataAccess\DataAccess;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

class BarberStoreServicesController extends DataAccess
{
    public function getServices(Request $request, Response $response, $args): Response
    {
        $result['services'] = $this->get('barber_store_services');

        $response->getBody()->write(json_encode($result));

        return $response
            ->withHeader('Content-Type', 'application/json');
    }
}