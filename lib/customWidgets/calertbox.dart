import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertBox extends StatelessWidget {
  final String text;
  final String title;
  final String okText;
  final VoidCallback onpressedCancel;
  final VoidCallback onpressedDelete;
   
   const CustomAlertBox({
    super.key, 
    required this.text, 
    required this.title, 
    required this.onpressedCancel, 
    required this.onpressedDelete, required this.okText
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:  Colors.white,
      title: Text(title,
      style: GoogleFonts.irishGrover(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold
        ),
        ),

        content: Text(text),
        actions: [
          TextButton(
            onPressed: onpressedCancel,
             child: Text("Cancel",
             style: GoogleFonts.irishGrover(
              color: Colors.grey
             ),
             )),

             TextButton(
              onPressed: onpressedDelete,
               child: Text(okText,
               style: GoogleFonts.irishGrover(
              color: Colors.red
             ),
               ))
        ],



    );
  }
}