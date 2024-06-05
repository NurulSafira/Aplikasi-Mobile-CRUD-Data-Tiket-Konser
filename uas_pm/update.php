<?php
require_once('connection.php');
parse_str(file_get_contents("php://input"), $_PUT);

$id_event = $_PUT['id_event'];
$nama = $_PUT['nama'];
$kategori = $_PUT['kategori'];
$tempat = $_PUT['tempat'];
$harga = $_PUT['harga'];
$waktu = $_PUT['waktu'];
$deskripsi = $_PUT['deskripsi'];

$query = "UPDATE events SET 
                nama = '$nama',
                kategori = '$kategori',
                tempat = '$tempat',
                waktu = '$waktu',
                harga = '$harga',
                deskripsi = '$deskripsi'
                WHERE id_event = '$id_event'";
$sql = mysqli_query($conn, $query);

// Menangani hasil dari query
if ($sql) {
    echo json_encode(array('message' => 'Data berhasil diubah'));

} else {
    echo json_encode(array('message' => 'Gagal mengubah data'));
}

?>