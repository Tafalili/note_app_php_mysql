import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Button extends StatelessWidget {
  late int hei;
  late int wid;
  late String text;
  late TextStyle stil;
  late Color color;
  VoidCallback  pressed;
   Button({
     required this.wid,
    required this.hei,
     required this.pressed,
     required this.color,
     required this.stil,
     required this.text
  }) ;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50)
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
        minWidth: wid.w,
        height: hei.h,
          child: Text("$text",style: stil),
          color: color,
          onPressed: pressed),
    );
  }
}
