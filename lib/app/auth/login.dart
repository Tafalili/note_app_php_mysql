import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w_php_mysql/main.dart';
import '/app/auth/crud.dart';
import '/tools/string.dart';
import '../../tools/valid.dart';
import '/tools/bottom.dart';
import '../../tools/formfild.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isloading = false;
  var crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Future Loginpage() async {
    if (formstate.currentState!.validate()) {
      _isloading = true;
      setState(() {});
      var response = await crud.postrequest(loginurl,
          {"email": emailcontroller.text, "password": passcontroller.text});
      sharedPref.setString("id", response["data"]["id"]).toString();
      sharedPref.setString("password", response["data"]["password"]);
      sharedPref.setString("email", response["data"]["email"]);
      _isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
           dialogType:DialogType.error ,
          title: "Wronge",
          titleTextStyle: GoogleFonts.abel(fontSize: 25),
          body: Text("There are no accont here "),
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _isloading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Image.asset(
                        "image/login.jpg",
                        height: 200.h,
                        width: 200.h,
                      ),
                    ),
                    Form(
                      autovalidateMode:AutovalidateMode.onUserInteraction ,
                        key: formstate,
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: FormFild(
                                  minlines: 1,
                                  maxlines: 1,
                                  bottom: 0.h,
                                  left: 20.w,
                                  right: 20.w,
                                  top: 0.h,
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
                                  lstyle: TextStyle(
                                      fontSize: 15.sp, color: Colors.blue),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 30.w),
                                child: FormFild(
                                  minlines: 1,
                                  maxlines: 1,
                                  top: 0.h,
                                  right: 20.w,
                                  left: 20.w,
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
                                  lstyle: TextStyle(
                                      fontSize: 15.sp, color: Colors.blue),
                                )),
                            SizedBox(height: 20.h),
                            Button(
                                wid: 50,
                                hei: 30,
                                pressed: () async {
                                  await Loginpage();
                                },
                                color: Colors.lightBlueAccent,
                                stil: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                                text: "Login"),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "If you don't have regestered here yet ->"),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed("/signup");
                                    },
                                    child: Text(
                                      "Signup ",
                                      style: GoogleFonts.aBeeZee(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                    )),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
