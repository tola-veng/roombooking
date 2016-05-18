<?php
session_start();

$_SESSION['user_id'] = null;
unset($_SESSION['user_id'] );

header("location:login.php");
exit();
?>