<?php

namespace App\controllers;

use Psr\Http\Message\ResponseInterface as Response;

abstract class BaseController
{
    const array NOT_AUTHORIZED_MESSAGE = ['message' => 'You are not authorized to access this resource.'];
    const array INVALID_PARAM_MESSAGE = ['message' => 'Invalid parameters.'];

    protected int $status = 200;
    protected bool $debug = false;
    protected ?string $error = null;

    protected function prepareResponse(Response &$response, mixed $body, string $contentType = 'Content-Type'): Response
    {
        if($this->status === 200) {
            $response->getBody()->write(json_encode($body));
        }
        else if($this->debug) {
            $response->getBody()->write(json_encode(['error' => $this->error]));
        }

        return $response
            ->withHeader($contentType, 'application/json')
            ->withStatus($this->status);
    }
}