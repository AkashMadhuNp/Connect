import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventViewRow extends StatelessWidget {
  final String title;
  final String body;
   const EventViewRow({super.key, 
   required this.title, 
   required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(
        left: 20,
        top: 10,
        right: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
          style: GoogleFonts.irishGrover(
            fontWeight: FontWeight.bold,
            fontSize: 18
            ),),
            Text(body,style: GoogleFonts.irishGrover(fontWeight: FontWeight.normal,
            fontSize: 16
            ),)
        ],
      ),
    );
  }
}