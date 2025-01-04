<?php

use App\controllers\BarberStoresController;
use App\controllers\BarbersController;
use App\controllers\BarberStoreServicesController;

if(!isset($app)){ exit(); }

$app->get("/barber-stores/list", BarberStoresController::class.":getStores");
$app->get("/barber-stores/{id}/barbers/list", BarbersController::class.":getBarbers");
$app->get("/barber-stores/{id}/services/list", BarberStoreServicesController::class.":getServices");
$app->get("/barber-stores/{id}/day/{day}/{month}/{year}/barber/{barberId}/service/{serviceId}/open-reservation", BarberStoresController::class.":getOpenReservation");