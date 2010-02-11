<?php

$config_file = trim($argv[1]);
define('BASEPATH', 'dummyvalue');

require($config_file);

echo json_encode($db['test']);
