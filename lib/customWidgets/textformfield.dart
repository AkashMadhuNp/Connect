import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final Icon icons;
   CustomTextForm({super.key, required this.hintText, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
                        
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: GoogleFonts.irishGrover(color: Colors.black),
                          prefixIcon: icons,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(color: Colors.black,width: 2)
                          )
                        ),
                      ),
    );
  }
}