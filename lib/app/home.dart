import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w_php_mysql/tools/model.dart';
import 'package:w_php_mysql/tools/updatepage.dart';
import 'package:w_php_mysql/tools/upload_file.dart';
import 'package:w_php_mysql/tools/view_tools/view_card.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../tools/string.dart';
import '../tools/valid.dart';
import 'auth/crud.dart';

class Home extends StatefulWidget {
  //  String title ;
  //  String content ;
  //   String id ;
  // Home({Key? key,required this.id,required this.content,required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AsyncSnapshot<dynamic>? snapshot1;
  late String text = text;

  TextEditingController titcontroller = TextEditingController();
  TextEditingController concontroller = TextEditingController();
  String title = "";

  String content = "";
  String? id;

  var crud = Crud();

  Future ViewData() async {
    var response =
        await crud.postrequest(viewdata, {"id": sharedPref.getString("id")});

    return response;
  }

  @override
  void initState() {
    titcontroller.text = title;
    concontroller.text = content;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  sharedPref.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                icon: Icon(Icons.exit_to_app)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/addscreen");
            },
            child: Icon(Icons.add)),
        body: ListView(
          children: [
            FutureBuilder(
                future: ViewData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "fail")
                      return Center(child: Text("No data here"));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          title = snapshot.data["data"][index]["n_title"];
                          content = snapshot.data["data"][index]["n_content"];
                          id = snapshot.data["data"][index]["n_content"];

                          return Dismissible(
                              secondaryBackground:
                                  Container(color: Colors.green),
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Edit screen"),
                                          content: Column(
                                            children: [
                                              TextFormField(
                                                controller: titcontroller,

                                                maxLines: 1,
                                                minLines: 1,
                                                validator: (val) {
                                                  return inputtitle(val!);
                                                },
                                                // controller: titcontroller.text=snapshot.data["data"][index]["n_title"],
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets
                                                            .only(
                                                                right: 20.w,
                                                                left: 0.h,
                                                                top: 0.h,
                                                                bottom: 20.w),
                                                    label: Text("title"),
                                                    labelStyle:
                                                        GoogleFonts.rakkas(
                                                            fontSize: 15.sp,
                                                            color: Colors.blue),
                                                    hintText:
                                                        "Insert title here",
                                                    hintStyle:
                                                        GoogleFonts.rakkas(
                                                            fontSize: 15.sp,
                                                            color: Colors
                                                                .black26
                                                                .withOpacity(
                                                                    0.2)),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.blue
                                                        .withOpacity(0.1)),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              TextFormField(
                                                controller: concontroller,
                                                maxLines: 1,
                                                minLines: 1,
                                                validator: (val) {
                                                  return inputtitle(val!);
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets
                                                            .only(
                                                                right: 20.w,
                                                                left: 0.h,
                                                                top: 0.h,
                                                                bottom: 20.w),
                                                    label: Text("content"),
                                                    labelStyle:
                                                        GoogleFonts.rakkas(
                                                            fontSize: 15.sp,
                                                            color: Colors.blue),
                                                    hintText:
                                                        "Insert content here",
                                                    hintStyle:
                                                        GoogleFonts.rakkas(
                                                            fontSize: 15.sp,
                                                            color: Colors
                                                                .black26
                                                                .withOpacity(
                                                                    0.2)),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)),
                                                      borderSide: BorderSide(
                                                          color: Colors.blue,
                                                          width: 2),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.blue
                                                        .withOpacity(0.1)),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  var response = await crud
                                                      .postrequest(
                                                          "http://10.0.2.2/notesApp/notes/updatenote.php",
                                                          {
                                                        "title":
                                                            titcontroller.text,
                                                        "content":
                                                            concontroller.text,
                                                        "id": snapshot
                                                            .data["data"][index]
                                                                ["n_id"]
                                                            .toString()
                                                      });
                                                  print("***********");
                                                  if (response["status"] ==
                                                      "success") {
                                                    print(
                                                        "success**************");
                                                    Navigator.of(context)
                                                        .pushNamed("/home");
                                                  }
                                                },
                                                child: Text(
                                                  "Save",
                                                  style: GoogleFonts.aclonica(
                                                      color: Colors.blue,
                                                      fontSize: 20.sp),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"))
                                          ],
                                        );
                                      });
                                }
                                if (direction == DismissDirection.startToEnd) {
                                  var response = await crud.postrequest(
                                      "http://10.0.2.2/notesApp/notes/deletenote.php",
                                      {
                                        "id_n": snapshot.data["data"][index]
                                                ["n_id"]
                                            .toString(),
                                        "file": snapshot.data["data"][index]
                                            ['n_image'].toString()
                                      });
                                  if (response["status"] == "success") {
                                    Navigator.of(context)
                                        .pushReplacementNamed("/home");
                                  }
                                }
                              },
                              background: Container(color: Colors.red),
                              key: Key(index.toString()),
                              child: Card1(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Update(
                                      imagename: snapshot.data["data"][index]["n_image"],
                                      title: snapshot.data["data"][index]
                                          ["n_title"],
                                      content: snapshot.data["data"][index]
                                          ["n_content"],
                                      id: snapshot.data["data"][index]["n_id"],
                                    ),
                                  ));
                                },
                                notedata: NotesData.fromJson(
                                    snapshot.data["data"][index]),
                                index: index,
                                snapshot: snapshot,
                              ));
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading ..."),
                    );
                  }
                  return Center(
                    child: Text("Loading ..."),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
