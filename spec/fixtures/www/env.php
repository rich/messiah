<?php

if (isset($_SERVER[$_GET['key']])) {
	echo "The key {$_GET['key']} exists and is {$_SERVER[$_GET['key']]}";
} else {
	echo "The key {$_GET['key']} does not exist";
}
