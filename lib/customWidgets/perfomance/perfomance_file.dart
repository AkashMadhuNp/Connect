import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfomanceCircle extends StatelessWidget {
  final String text1;
  final IconData icon;
  final Color color;
  final String text2;
   PerfomanceCircle({
    super.key, 
    required this.text1, 
    required this.icon, 
    required this.color, required this.text2
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 15,
          ),
          child: Text(
            text1,
            style: GoogleFonts.irishGrover(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            ),
          ),


          Row(
            children: [
              Icon(icon,color: color,),

              const SizedBox(width: 10,),

              Text(text2,style: GoogleFonts.irishGrover(fontSize: 15),)
            ],
          )
      ],
    );
  }
}