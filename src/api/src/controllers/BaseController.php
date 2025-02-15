<?php

namespace App\controllers;

use Psr\Http\Message\ResponseInterface as Response;

abstract class BaseController
{
    const array NOT_AUTHORIZED_MESSAGE = ['message' => 'You are not authorized to access this resource.'];

    protected int $status = 200;

    protected function prepareResponse(Response &$response, mixed $body, string $contentType = 'Content-Type'): Response
    {
        if($this->status === 0) {
            $response->getBody()->write(json_encode($body));
        }

        return $response
            ->withHeader($contentType, 'application/json')
            ->withStatus($this->status);
    }
}