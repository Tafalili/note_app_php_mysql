<?php

include "../connect.php";
$imagename = filterequest("imagename");
$noteid = filterequest("id");
if(isset($_FILES["file"])){
    deletefile("../upload",$imagename);
    $imagename  = uploadFile("file");


}


    deletefile("../upload",$imagename);
        $stmt = $con->prepare("UPDATE `notes` SET `n_image`=? WHERE  `n_id` = ?");
    $stmt->execute(array($imagename,$noteid));
    $count = $stmt->rowCount();
    if($count > 0){
        echo json_encode(array("status"=>"success"));
    }else{
        echo json_encode(array("status"=>"success"));
    }








?>