<?php
define('MB' , 1048576);

function filterequest($requestname){
   return htmlspecialchars(strip_tags($_POST[$requestname])) ;
}
function uploadFile($requiredrequest){
   global $msgboxError;
   $imagename = rand(1000,10000) . $_FILES[$requiredrequest]["name"];
   $imagetemp = $_FILES[$requiredrequest]["tmp_name"];
   $imagesize = $_FILES[$requiredrequest]["size"];
   $allowExt = array("jpg","png","psd","mp3","mp4","gif");
   $stringTOarray = explode(".",$imagename);
   $ext=end($stringTOarray);
   $ext =strtolower($ext);
   if(!empty($imagename) && !in_array($ext , $allowExt)){
      $msgboxError[]="ext";
   }
   if($imagesize > 2 * MB){
      $msgboxError[]="SIZE";
   }
   if(empty($msgboxError)){
      move_uploaded_file($imagetemp,"../upload/".$imagename);
      return $imagename;
   }else{
   return "fail";
   }

}

function deletefile($dir , $imagename){
      unlink($dir . "/" . $imagename);
}

function checkAuthenticate(){
   if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

       if ($_SERVER['PHP_AUTH_USER'] != "wael" ||  $_SERVER['PHP_AUTH_PW'] != "wael12345"){
           header('WWW-Authenticate: Basic realm="My Realm"');
           header('HTTP/1.0 401 Unauthorized');
           echo 'Page Not Found';
           exit;
       }
   } else {
       exit;
   }
}


?>