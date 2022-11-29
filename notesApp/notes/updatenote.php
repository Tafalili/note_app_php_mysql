<?php
include "../connect.php";
$title = filterequest("title");
$content = filterequest("content");
$noteid = filterequest("id");
$imagename = filterequest("imagename");
if(isset($_FILES["file"])){

    deletefile("../upload" , $imagename);
    $imagename = uploadFile("file");
}
$stmt= $con->prepare("UPDATE `notes` SET `n_title`=?,
`n_content`=? , `n_image`=? WHERE `n_id` = ?");
$stmt->execute(array($title , $content ,$imagename, $noteid));
$count = $stmt->rowCount();
if($count > 0 ){
echo json_encode(array("status"=>"success"));

}else{
    echo json_encode(array("status"=>"fail"));
}



?>