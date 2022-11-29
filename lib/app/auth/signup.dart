import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/auth/crud.dart';
import '/tools/string.dart';
import '/tools/valid.dart';
import '/tools/bottom.dart';

import '../../tools/formfild.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _LoginState();
}

class _LoginState extends State<signup> {
  bool _isloading = false;
  var crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();

  Future Signup() async {
if(formstate.currentState!.validate()){
  _isloading=true;
  setState(() {

  });
  var response1 = await crud.postrequest(signupurl, {
    "username": usercontroller.text,
    "password": passcontroller.text,
    "email": emailcontroller.text
  });
  _isloading=false;
  setState(() {

  });
  if(response1['status']=='success'){

    Navigator.of(context).pushNamedAndRemoveUntil("/check", (route) => false);

  }else{
    print("not response ");
  }
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: _isloading==true? Center(child: CircularProgressIndicator()):Container(
              child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Image.asset(
                "image/signup1.jpg",
                height: 200.h,
                width: 200.h,
              ),
            ),
            Form(
              key: formstate,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: FormFild(
                        minlines: 1,
                        maxlines: 1,
                        top: 0.h,
                        right: 20.sp,
                        left: 20.sp,
                        bottom: 0.h,

                        vali: (val) {
                          return inputvalidator(val!, 20, 4);

                        },
                        mycontroller: usercontroller,
                        fill: true,
                        lable: "Username",
                        obscure: false,
                        title: "eg.Ahmed",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black.withOpacity(0.2)),
                        lstyle: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: FormFild(
                        minlines: 1,
                        maxlines: 1,
                        top: 0.h,
                        right: 20.w,
                        left: 20.w,
                        bottom: 0.h,

                        vali: (val) {
                         return validateEmail(val);

                        },
                        mycontroller: emailcontroller,
                        fill: true,
                        lable: "Email",
                        obscure: false,
                        title: "example@gmail.com",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black.withOpacity(0.2)),
                        lstyle: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: FormFild(
                        minlines: 1,
                        maxlines: 1,
                        top: 0.h,
                        right: 20.sp,
                        left: 20.sp,
                        bottom: 0.h,

                        vali: (val) {
                          return inputvalidator(val!, 20, 4);

                        },
                        mycontroller: passcontroller,
                        fill: true,
                        title: "keep your password secret",
                        obscure: true,
                        lable: "Password",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black.withOpacity(0.2)),
                        lstyle: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      )),
                  SizedBox(height: 20.h),
                  Button(
                      wid: 50,
                      hei: 30,
                      pressed: () async{
                       await Signup();
                      },
                      color: Colors.lightBlueAccent,
                      stil: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                      text: "signup"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("If you already have account  ->"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/");
                          },
                          child: Text(
                            "LogIn ",
                            style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ])),
        ));
  }
}
