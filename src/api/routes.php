<?php

use App\controllers\BarberStoresController;
use App\controllers\BarbersController;

if(!isset($app)){ exit(); }

$app->get("/barber-stores/list", BarberStoresController::class.":getStores");
$app->get("/barber-stores/{id}/barbers/list", BarbersController::class.":getBarbers");