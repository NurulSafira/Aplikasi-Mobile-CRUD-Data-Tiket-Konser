<?php

// Koneksi ke database
require 'connection.php';

// Query SQL untuk mengambil data dari tabel events
$sql = "SELECT * FROM events";

// Eksekusi query
$result = $conn->query($sql);

// Mengecek apakah query berhasil dieksekusi
if ($result->num_rows > 0) {
    // Array untuk menyimpan data acara
    $events = array();

    // Mengambil setiap baris hasil query
    while ($row = $result->fetch_assoc()) {
        // Menambahkan data acara ke dalam array
        $events[] = $row;
    }

    // Mengkonversi array ke format JSON
    $json = json_encode($events, JSON_PRETTY_PRINT);

    // Menetapkan tipe konten header untuk JSON
    header('Content-Type: application/json');

    // Mengirimkan data JSON sebagai respons
    echo $json;
} else {
    // Jika tidak ada hasil dari query, mengirimkan pesan kesalahan
    echo json_encode(array('message' => 'No events found.'));
}

// Menutup koneksi ke database
$conn->close();

?>
