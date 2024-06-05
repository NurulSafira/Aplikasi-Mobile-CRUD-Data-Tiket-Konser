<?php
    require_once('connection.php');
    parse_str(file_get_contents("php://input"), $value);

    $id_event = $value['id_event'];

    $query = "DELETE FROM events WHERE id_event = '$id_event'";
    $sql = mysqli_query($conn, $query);

    if ($sql) {
        echo json_encode ( array('message' => 'event berhasil dihapus' ) );
        
    } else {
        echo json_encode ( array('message' => 'Gagal menghapus event' ) );
    }

?>
