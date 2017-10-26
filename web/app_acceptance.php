<?php

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Debug\Debug;


/**
 * @var Composer\Autoload\ClassLoader $loader
 */
require __DIR__.'/../vendor/autoload.php';
Debug::enable();

$kernel = new AppKernel('acceptance', true);

$kernel->loadClassCache();
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);