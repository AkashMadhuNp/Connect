import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingView extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
   FloatingView({super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,size: 30,color: Colors.white,),
      title: Padding(padding: EdgeInsets.only(left: 28.0),
      child: Text(text,style: GoogleFonts.irishGrover(fontSize: 24,color: Colors.white),),
      ),
    );
  }
}