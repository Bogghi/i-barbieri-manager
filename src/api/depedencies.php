<?php

require_once 'src/DataAccess/DataAccess.php';
require_once 'src/controllers/BarberController.php';

use App\controllers\BarberController;
use App\DataAccess\DataAccess;

if(!isset($app)){
    header("location: /");
    exit();
}
$container = $app->getContainer();

$container['App\DataAccess\DataAccess'] = function($c) {
    return new DataAccess();
};
$container["App\controllers\BarberController"] = function($c) {
    return new BarberController();
};