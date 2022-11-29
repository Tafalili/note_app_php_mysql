<?php 
include "../connect.php";
$id = filterequest("id_n");
$imagename = filterequest("file");
$stmt = $con->prepare("DELETE FROM `notes` WHERE n_id = ?");
$stmt->execute(array($id));
$data = $stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count > 0 ){
    deletefile("../upload",$imagename);
    echo json_encode(array("status" => "success"));
}else{
    echo json_encode(array("status"=>"fail"));
}
?>