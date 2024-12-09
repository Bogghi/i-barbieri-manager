<?php

if(!isset($app)){ exit(); }

$app->get("/testRoute", TestController::class.":test");