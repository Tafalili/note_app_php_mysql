import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:w_php_mysql/tools/string.dart';
import 'package:w_php_mysql/tools/valid.dart';

import '../app/auth/crud.dart';
import '../main.dart';
import 'formfild.dart';
class Update extends StatefulWidget {
  final String title;
  final String content ;
  final String id;
  final String imagename ;
  const Update({required this.imagename,required this.content,required this.title,required this.id}) ;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  File?myfile;
  bool _isloading = false;
  Crud crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  @override
  void initState() {
    titlecontroller.text=widget.title;
    contentcontroller.text=widget.content;
    super.initState();
  }

  Future updateNote() async {

    if (formstate.currentState!.validate()) {
      _isloading = true;
      setState(() {});
      var response2;
      if(myfile==null){
        response2 = await crud.postrequest(
            editurl
            , {
          "id": widget.id ,
          "title": titlecontroller.text,
          "content": contentcontroller.text,
          "imagename":widget.imagename
        });
        _isloading = false;
        setState(() {});
        if (response2['status']=="success") {
          print("status is success");
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          print("fail");


          // AwesomeDialog(
          //     context: context,
          //     title: "Error",
          //     dialogType: DialogType.error,
          //     body: const Text("Some thing was error check connection and try again later "));
        }
      }else{
       response2 = await crud.postFile(editurl, {
         "id": widget.id ,
         "title": titlecontroller.text,
         "content": contentcontroller.text,
         "imagename":widget.imagename
       },myfile!);
        _isloading = false;
        setState(() {});
        if (response2['status'] == "success") {
          print("status is success");
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          print("fail");

          // AwesomeDialog(
          //     context: context,
          //     title: "Error",
          //     dialogType: DialogType.error,
          //     body: const Text("Some thing was error check connection and try again later "));
        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.update),onPressed:()async {
          return await updateNote();

        },),
        appBar: AppBar(title: Text("Add screen")),
        body:_isloading==true?const Center(child: CircularProgressIndicator(),): Container(
          child: Form(
            key: formstate,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                FormFild(
                  minlines: 1,
                  maxlines: 1,
                  top: 0.h,
                  right: 20.w,
                  left: 20.w,
                  bottom: 0.h,
                  title: "Insert title here",
                  fill: true,
                  lable: "title",
                  obscure: false,
                  mycontroller: titlecontroller,
                  vali: (val) {
                    return inputtitle(val!);
                  },
                  lstyle:
                  GoogleFonts.rakkas(fontSize: 15.sp, color: Colors.blue),
                  style: GoogleFonts.rakkas(
                      fontSize: 15.sp, color: Colors.black26.withOpacity(0.2)),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 100,
                  child: FormFild(
                    minlines: 1,
                    maxlines: 7,
                    top: 0.h,
                    right: 20.w,
                    left: 20.w,
                    bottom: 0.h,
                    title: "Insert content here",
                    fill: true,
                    lable: "content",
                    obscure: false,
                    mycontroller: contentcontroller,
                    vali: (val) {
                      return inputtitle(val!);
                    },
                    lstyle:
                    GoogleFonts.rakkas(fontSize: 15.sp, color: Colors.blue),
                    style: GoogleFonts.rakkas(
                        fontSize: 15.sp, color: Colors.black26.withOpacity(0.2)),
                  ),
                ),
                MaterialButton(



                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),

                  onPressed: () {
                    showModalBottomSheet(context: context,
                        builder: (context) => Container(
                          height: 100.h,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                            InkWell(onTap: ()async{
                              XFile?xfile = await ImagePicker().pickImage(source:ImageSource.gallery );
                              myfile = File(xfile!.path);
                            },
                              child:
                              Row(
                                children: [
                                  Icon(Icons.add_box,size: 35.sp),
                                  SizedBox(width: 10.w,),
                                  Text("Gallery",style: GoogleFonts.acme(fontSize: 30.sp))
                                ],
                              ),),
                            SizedBox(width:20.w,),
                            InkWell(onTap:()async{
                              XFile?xfile = await ImagePicker().pickImage(source:ImageSource.camera );
                              myfile = File(xfile!.path);
                            },
                              child:
                              Row(
                                children: [
                                  Icon(Icons.camera_alt,size: 35.sp),
                                  SizedBox(width: 10.w,),
                                  Text("Camera",style: GoogleFonts.acme(fontSize: 30.sp),)
                                ],
                              ),)

                          ],),
                        ));
                  },
                  child: Text("Add Image",
                      style: GoogleFonts.abel(
                          fontSize: 20.sp, color: Colors.white)),
                  color:myfile==null ? Colors.blue : Colors.green,
                ),

              ],
            ),
          ),
        ));
  }
}
