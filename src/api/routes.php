<?php

use App\controllers\BarberStoresController;
use App\controllers\BarbersController;
use App\controllers\BarberStoreServicesController;
use App\controllers\AuthController;
use Slim\Routing\RouteCollectorProxy;

if(!isset($app)){ exit(); }

$app->get("/barber-stores/list", BarberStoresController::class.":getStores");

$app->group("/barber-stores/{id}", function(RouteCollectorProxy $group) {

    $group->get("/barbers/list", BarbersController::class.":getBarbers");
    $group->get("/services/list", BarberStoreServicesController::class.":getServices");
    $group->get(
        "/day/{day}/{month}/{year}/barber/{barberId}/service/{serviceId}/open-reservation",
        BarberStoresController::class.":getOpenReservation"
    );
    $group->post(
        "/day/{day}/{month}/{year}/barber/{barberId}/service/{serviceId}/slot/{start}/{end}/book-reservation",
        BarberStoresController::class.":bookReservation"
    );
    $group->post(
        "/order/add",
        BarberStoresController::class.":addOrder"
    );

});

$app->post("/barbers/login", AuthController::class.":login");
$app->post("/barbers/signup", AuthController::class.":signup");
$app->post("/barbers/refresh", AuthController::class.":loginByRefreshToken");