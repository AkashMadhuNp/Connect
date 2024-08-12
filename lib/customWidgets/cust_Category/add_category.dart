import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 70,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(20),
        dashPattern: [10,10],
        color: Colors.grey,
        strokeWidth: 2,
        child: Center(
          child: Text(
            " + Add Category",
          style: GoogleFonts.irishGrover(
            fontWeight: FontWeight.w600,
            color: Colors.grey
          ),),
        )),
    );
  }
}