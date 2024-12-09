<?php
use Slim\Factory\AppFactory;

require __DIR__.'/vendor/autoload.php';
require __DIR__.'/env.php';

$app = AppFactory::create();

require 'depedencies.php';
require 'routes.php';

$app->run();