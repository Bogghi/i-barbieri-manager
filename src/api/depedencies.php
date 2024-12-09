<?php

require_once 'src/controllers/TestController.php';

if(!isset($app)){
    header("location: /");
    exit();
}
$container = $app->getContainer();

$container["TestController"] = function($c) {
    return new TestController();
};