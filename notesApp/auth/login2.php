<?php
include "../connect.php";

$email = filterequest("email");
$password = filterequest("password");
$stmt=$con->prepare("SELECT * FROM `users` WHERE `email` = ? AND `password` = ?");
$stmt->execute(array($email,$password));
$data = $stmt->fetch(PDO::FETCH_ASSOC);
$cunt = $stmt->rowCount();
if($cunt > 0){
   echo json_encode(array("status" => "success","data"=>$data) );

}else{
    echo json_encode(array("status" => "fail"));
}



?>