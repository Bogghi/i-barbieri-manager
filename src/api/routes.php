<?php

use App\controllers\BarberStoresController;

if(!isset($app)){ exit(); }

$app->get("/barber-stores/list", BarberStoresController::class.":getBarbers");