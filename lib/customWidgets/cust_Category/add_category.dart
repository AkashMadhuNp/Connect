import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [5, 2],
        color: Colors.grey,
        strokeWidth: 2,
        child: Center(
          child: Container(
            //color: Colors.orange,
            height: isWeb ? 40 : 100,
            width: isWeb ? double.infinity : double.infinity,
            child: Center(
              child: Text(
                "+ Add Category",
                style: GoogleFonts.irishGrover(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: isWeb ? 16 : 14,
                ),
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}