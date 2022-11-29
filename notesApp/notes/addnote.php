<?php
include "../connect.php";
$title = filterequest("title");
$content = filterequest("content");
$notesuser = filterequest("noteuser");
$imagename  = uploadFile("file");
if($imagename != "fail"){
    $stmt= $con->prepare("INSERT INTO `notes`( `n_title`,`n_content`,`notes_user`,`n_image`) VALUES ( ? , ? , ?, ? );");
    $stmt->execute(array($title , $content , $notesuser , $imagename ));
    $count = $stmt->rowCount();
    if($count > 0 ){
    echo json_encode(array("status"=>"success"));
    
    }else{
        echo json_encode(array("status"=>"fail"));
    }
    
}



?>