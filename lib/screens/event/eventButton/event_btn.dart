
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EventButton extends StatelessWidget {
  String text;
  double width;
  VoidCallback onPressed;
  EventButton({super.key, required this.text, required this.onPressed,required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(width, 50)),
          backgroundColor: MaterialStatePropertyAll(Colors.orange),
          foregroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.irishGrover(
          fontSize: 25,
          color: Colors.white,
          letterSpacing: 2
        ),
      ),
    );
  }
}
