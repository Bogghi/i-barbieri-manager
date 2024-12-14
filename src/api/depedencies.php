<?php

require_once 'src/DataAccess/DataAccess.php';
require_once 'src/controllers/BarberStoresController.php';

use App\controllers\BarberStoresController;
use App\DataAccess\DataAccess;

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