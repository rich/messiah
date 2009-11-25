<?php
echo $_SERVER['HTTP_NOPE'];
setcookie('a-cookie', 'thing');
echo "Hello";
echo "Host is " . $_SERVER['HTTP_HOST'];
?>
<a href="/another.php">Click Me</a>