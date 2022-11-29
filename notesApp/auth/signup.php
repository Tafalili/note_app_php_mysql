<?php
include "../connect.php";

$username = filterequest("username");
$email = filterequest("email");
$password = filterequest("password");


$stmt = $con -> prepare("INSERT INTO `users`( `username`, `email`, `password`) VALUES (?,?,?)") ;
$stmt->execute(array($username,$email,$password));
$count = $stmt->rowCount();
if($count > 0 ){
    echo json_encode(array ("status" => "success"));
}else{
    echo json_encode( array("status" => "fail"));
}


?>





