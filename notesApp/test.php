<?php
    define("MB" , 1048576);

include "connect.php";
global $messsagebox ;

function upload($request){

    $imagename = rand(1000,10000).$_FILES[$request]["name"];
    $image_temp = $_FILES[$request]["tmp_name"];
    $imagesize = $_FILES[$request]["size"];
    $allowext = array("jpg","png","gif","mp3");
    $stringtoarray = explode('.',$imagename);
    $ext = end($stringtoarray);
    $ext = strtolower($ext);
    if(!empty($imagename) && !in_array($ext , $allowext)){
     $messsagebox[]= "EXT";
    }
    if($imagesize > 2*MB ){
        $messsagebox[] = "size";
    }
    if(empty($messsagebox)){
        move_uploaded_file($image_temp,"..uploade/".$imagename);
    }else{
        print_r($messsagebox);
    }

}

?>