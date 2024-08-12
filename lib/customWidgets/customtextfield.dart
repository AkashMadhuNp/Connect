import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? enabled;
  final AutovalidateMode? mode;
  final TextEditingController customController;
  final Widget? icon;
  final String? Function(String?)? validator;
  final int? maxLines;

   CustomTextField({super.key,
    required this.hintText,
     this.enabled, 
     this.mode, 
     required this.customController, 
     this.icon, 
     this.validator,
      this.maxLines
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      enabled: enabled,
      autovalidateMode: mode,
      maxLines: maxLines,
      controller: customController,
      validator: validator,

      
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: icon,
                  ),
              
                  hintText: hintText,
 
 
                  hintStyle: GoogleFonts.irishGrover(),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ) ,
              
              );
  }
}