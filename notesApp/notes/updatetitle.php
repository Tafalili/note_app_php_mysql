<?php
include "../connect.php";
$title = filterequest("title");
$noteid = filterequest("id");
$stmt= $con->prepare("UPDATE `notes` SET `n_title`=?
 WHERE `n_id` = ?");
$stmt->execute(array($title  , $noteid));
$count = $stmt->rowCount();
if($count > 0 ){
echo json_encode(array("status"=>"success"));

}else{
    echo json_encode(array("status"=>"fail"));
}



?>