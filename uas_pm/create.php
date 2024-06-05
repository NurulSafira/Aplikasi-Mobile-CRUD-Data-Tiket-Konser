<?php
require 'connection.php';

// Memeriksa apakah data yang diharapkan ada dalam array $_POST
if (isset($_POST['nama'], $_POST['kategori'], $_POST['waktu'], $_POST['tempat'], $_POST['deskripsi'], $_POST['harga'])) {
    // Mendapatkan data dari array $_POST
    $nama = $_POST['nama'];
    $kategori = $_POST['kategori'];
    $waktu = $_POST['waktu'];
    $tempat = $_POST['tempat'];
    $deskripsi = $_POST['deskripsi'];
    $harga = $_POST['harga'];

    // Menjalankan query SQL untuk menambahkan data event ke dalam tabel events
    $sql = "INSERT INTO events (nama, kategori, waktu, tempat, deskripsi, harga) VALUES ('$nama', '$kategori', '$waktu', '$tempat', '$deskripsi', '$harga')";
    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    echo "Data not complete";
}

// Menutup koneksi ke database
$conn->close();
?>