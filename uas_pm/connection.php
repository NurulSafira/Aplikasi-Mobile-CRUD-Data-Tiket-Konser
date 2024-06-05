<?php
    define('HOST', 'localhost');
    define('USER', 'root');
    define('PASS', '');
    define('DB', 'events_uas');

    $conn = mysqli_connect( HOST, USER, PASS, DB) or die ('unabel conect');

    header('Content-Type: application/json');
?>