<?php

use \App\controllers\BarberController;

if(!isset($app)){ exit(); }

$app->get("/testRoute", TestController::class.":test");
$app->get("/barbers/list", BarberController::class.":getBarbers");