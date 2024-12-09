<?php

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;
class TestController
{
    public function test(Request $request, Response $response, $args)
    {
        $response->getBody()->write("sto cazzo grande quanto una casa");
        return $response;
    }
}