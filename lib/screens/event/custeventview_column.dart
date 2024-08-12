import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventViewcolumn extends StatelessWidget {
  final String title;
  final String body;
  const EventViewcolumn({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.irishGrover(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 75, 46, 1)
          ),),
          const SizedBox(
            height: 10,
          ),
          Text(body,  style: GoogleFonts.irishGrover(

            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w900,
            color: Colors.black

          ))
        ],
      ),
    );
  }
}
