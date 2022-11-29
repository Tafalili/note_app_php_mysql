import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFild extends StatelessWidget {
  late String title;
 late  String lable;
  late bool fill;
  late bool obscure;
  late TextStyle style;
  late TextStyle lstyle;
  late double right ;
  late double left ;
  late double top;
  late double bottom;
  late int maxlines;
  late int minlines;
  String? Function(String?)? vali;
  late TextEditingController mycontroller;
   FormFild({required this.minlines ,required this.maxlines ,required this.top,required this.left,required this.right,required this.bottom,required this.vali,required this.mycontroller,required this.obscure, required this.fill,required this.title, required this.lable,required this.style,required this.lstyle}) ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      minLines: minlines,
      validator: vali,
      controller: mycontroller,
      obscureText: obscure,
      decoration: InputDecoration(

          contentPadding:
          EdgeInsets.only(right:  right, left:  left ,top:  top,bottom:  bottom),
          label: Text("$lable"),
          labelStyle: lstyle,
          hintText: "$title",
          hintStyle:style,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          filled: fill,
          fillColor: Colors.blue.withOpacity(0.1)),
    );
  }
}
