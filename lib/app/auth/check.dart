import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("image/true.jpg"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login", (route) => false);

                  },
                  child: Text("هنا",style: GoogleFonts.rakkas(fontSize: 20),)),
              Text("لقد قمت بتسجيل بنجاح يمكنك تسجيل الدخول بالنقر",style: GoogleFonts.rakkas(fontSize: 20),),
            ],
          ),
        ],
      ),
    );
  }
}
