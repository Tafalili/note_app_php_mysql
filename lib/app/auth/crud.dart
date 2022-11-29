import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http ;
import 'package:path/path.dart';


String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'wael:wael12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};


class Crud{
  getrequest(String urlget) async {
    try {
      var response = await http.get(Uri.parse(urlget));
      // return responsebody;
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error");
      }
    }catch(e){
    print("Error $e");}

  }

  postrequest(String urlpost , Map data)async {
    try {
      var response = await http.post(Uri.parse(urlpost), body: data,headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }else{
        print("There are error in response");
      }
    }catch(e){
      print("Error $e");
    }
  }

  postFile(String link , Map data , File file  )async{
    var request = await http.MultipartRequest("POST", Uri.parse(link));
    var length = await file.length();
    var stream = await http.ByteStream(file.openRead());
    var multipartfile = await http.MultipartFile("file",stream,length,filename: basename(file.path));
    request.files.add(multipartfile);
    request.headers.addAll(myheaders);
    data.forEach((key, value) { request.fields[key]=value;});
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if(myrequest.statusCode==200){
      return jsonDecode(response.body);
    }else {
      print("error");
    }


  }
}
