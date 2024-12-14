<?php

use \App\controllers\BarberController;

if(!isset($app)){ exit(); }

$app->get("/barbers/list", BarberController::class.":getBarbers");