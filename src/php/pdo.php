<?php
try {
    $conn = new PDO('mysql:host=localhost; port=3306; dbname=test', 'root', 'usbw');
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo 'Falha na conexão: ' . $e->getMessage();
}
?>
