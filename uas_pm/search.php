<?php

require_once('connection.php');

function search($keyword) {
    global $conn;

    $keyword = mysqli_real_escape_string($conn, $keyword);

    $query = "SELECT * FROM events WHERE nama LIKE '%$keyword%'";
    $sql = mysqli_query($conn, $query);

    $result = array();
    while ($row = mysqli_fetch_array($sql)) {
        $result[] = array(
            'id_event' => $row['id_event'],
            'nama' => $row['nama'],
            'deskripsi' => $row['deskripsi'],
            'waktu' => $row['waktu'],
            'tempat' => $row['tempat'],
            'harga' => $row['harga'],
            'kategori' => $row['kategori'],
        );
    }
    return $result;
}

$keyword = isset($_GET['keyword']) ? $_GET['keyword'] : '';

$result = search($keyword);

echo json_encode($result);

?>
