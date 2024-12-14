<?php

require_once 'src/DataAccess/DataAccess.php';
require_once 'src/controllers/BarberStoresController.php';
require_once 'src/controllers/BarberStoreServicesController.php';
require_once 'src/controllers/BarbersController.php';

use App\DataAccess\DataAccess;
use App\controllers\BarberStoresController;
use App\controllers\BarbersController;
use App\controllers\BarberStoreServicesController;

if(!isset($app)){
    header("location: /");
    exit();
}
$container = $app->getContainer();

$container['App\DataAccess\DataAccess'] = function($c) {
    return new DataAccess();
};
$container["App\controllers\BarberStoresController"] = function($c) {
    return new BarberStoresController();
};
$container["App\controllers\BarbersController"] = function($c) {
    return new BarbersController();
};
$container["App\controllers\BarberStoreServicesController"] = function($c) {
    return new BarberStoreServicesController();
};