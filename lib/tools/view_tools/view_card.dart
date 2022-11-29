import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:w_php_mysql/app/auth/crud.dart';
import 'package:w_php_mysql/tools/model.dart';
import 'package:w_php_mysql/tools/string.dart';

import '../../main.dart';

class Card1 extends StatefulWidget {
final NotesData notedata;
  void Function()? onTap;


  int index;
  AsyncSnapshot<dynamic> snapshot;


   Card1(
      {Key? key,
        required this.index,
        required this.snapshot,
        required this.onTap,
        required this.notedata
   ,})
      : super(key: key);

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  Crud crud = Crud();
  Future updateImageote() async{
    var response;
    if(myfile ==null){
      response = await crud.postrequest(editurl, {
        "id":widget.notedata.nId,
        "title":widget.notedata.nTitle,
        "content":widget.notedata.nContent,
        "imagename":widget.notedata.notesimage
      });
    if(response["status"]=="success"){
      print("success");
      Navigator.of(context).pushNamed("/home");
    }else{
      print("fail");
    }
    }else{
      response=await crud.postFile(editurl, { "id":widget.notedata.nId,
        "title":widget.notedata.nTitle,
        "content":widget.notedata.nContent,
        "imagename":widget.notedata.notesimage}, myfile!);
      if(response["status"]=="success"){
        print("success");
        Navigator.of(context).pushNamed("/home");
      }else{
        print("fail");
      }
    }
  }

  // Future AddNote() async {
  //   if(myfile==null){
  //     return AwesomeDialog(context: context,title: "هام",body: Text("لا توجد صوره"))..show();
  //   }
  //     setState(() {});
  //     var response2 = await crud.postFile("http://10.0.2.2/notesApp/notes/updateimg.php", {
  //       "id": sharedPref.getString("id"),
  //     },myfile!);
  //     setState(() {});
  //     if (response2['status'] == "success") {
  //       print("status is success");
  //       Navigator.of(context).pushReplacementNamed("/home");
  //     } else {
  //       print("fail");
  //
  //       // AwesomeDialog(
  //       //     context: context,
  //       //     title: "Error",
  //       //     dialogType: DialogType.error,
  //       //     body: const Text("Some thing was error check connection and try again later "));
  //     }
  //
  // }

  File? myfile;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                offset: Offset(0.w, -2.h),
                color: Colors.black)
          ]),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(

                    child: widget.notedata.notesimage!.isEmpty?Image.asset("image/true.jpg"):Image.network(
                      "http://10.0.2.2/notesApp/upload/${widget.notedata.notesimage}",
                      height: 80.h,
                    ),
                    onTap: () {
                      showModalBottomSheet(context: context,
                          builder: (context) =>
                              Container(
                                height: 100.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(onTap: () async {
                                      XFile?xfile = await ImagePicker()
                                          .pickImage(
                                          source: ImageSource.gallery);
                                      myfile = File(xfile!.path);
                                      updateImageote();
                                      setState(() {

                                      });
                                      Navigator.of(context).pop();
                                    },
                                      child:
                                      Row(
                                        children: [
                                          Icon(Icons.add_box, size: 35.sp),
                                          SizedBox(width: 10.w,),
                                          Text("Gallery",
                                              style: GoogleFonts.acme(
                                                  fontSize: 30.sp))
                                        ],
                                      ),),
                                    SizedBox(width: 20.w,),
                                    InkWell(onTap: () async {
                                      XFile?xfile = await ImagePicker()
                                          .pickImage(
                                          source: ImageSource.camera);
                                      myfile = File(xfile!.path);
                                      updateImageote();
                                      setState(() {

                                      });
                                      Navigator.of(context).pop();
                                    },
                                      child:
                                      Row(
                                        children: [
                                          Icon(Icons.camera_alt, size: 35.sp),
                                          SizedBox(width: 10.w,),
                                          Text("Camera",
                                            style: GoogleFonts.acme(
                                                fontSize: 30.sp),)
                                        ],
                                      ),)

                                  ],),
                              ));
                    }
                  )
                  ),
              Expanded(
                  flex: 2,
                  child: ListTile(
                    onTap:
                       widget.onTap,


                    title: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      initialValue: "${widget.notedata.nTitle}",
                      onFieldSubmitted: (value) async{
                        {
                          var response = await crud.postrequest("http://10.0.2.2/notesApp/notes/updatetitle.php",
                              {"id": widget.snapshot.data["data"][widget.index]["n_id"].toString(),"title":value});
                          if(response["status"]=="success"){
                            Navigator.of(context).pushReplacementNamed("/home");
                          }
                        }
                      },
                    ),
                    subtitle: Text("${widget.notedata.nContent}"),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        )
      ],
    );
  }
}
