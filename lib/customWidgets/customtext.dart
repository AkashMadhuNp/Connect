import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
   CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
     text,style: GoogleFonts.irishGrover(color: Colors.black,fontSize: 22), 
    );
  }
}