import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w_php_mysql/app/auth/signup.dart';
import 'package:w_php_mysql/tools/addscreen.dart';
import 'package:w_php_mysql/tools/updatepage.dart';

import 'app/auth/check.dart';
import 'app/auth/login.dart';
import 'app/home.dart';
late SharedPreferences sharedPref ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  const Size(360, 690) ,
        minTextAdapt: true,
        splitScreenMode: true,

        builder:(context, child) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           initialRoute: sharedPref.getString("id") == null?"/":"/home",
         routes:{
           "/" : (context)=>Login(),
           "/check":(context) => Check(),
           "/home":(context) => Home(),
           "/signup":(context) => signup(),
           "/login":(context) => Login(),
           "/addscreen" :(context) => AddMe(),
         } ,

          );
        }, );

  }
}
