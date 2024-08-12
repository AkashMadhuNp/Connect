import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final AutovalidateMode mode;
  final String? Function(String?)? validator;
  final IconData icon;
  final bool obsecureText;
  final VoidCallback onPressed;
  final String hintText;
  
   
   
   PasswordField({super.key, 
   required this.controller, 
   required this.mode, 
   required this.validator, 
   required this.icon, 
   required this.obsecureText, 
   required this.onPressed, 
   required this.hintText
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top:20
      ),

      child: TextFormField(
        autovalidateMode: mode,
      
        controller: controller,
        validator: validator,
        obscureText: obsecureText,
        decoration: InputDecoration(
          errorMaxLines: 5,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(onPressed:onPressed, icon:Icon(icon)),
          ),

          hintText: hintText,
          hintStyle: GoogleFonts.irishGrover(),
          contentPadding: EdgeInsets.only(left: 40,top: 15,bottom: 15),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusColor: Colors.purple,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple,width: 2),
            borderRadius: BorderRadius.circular(30),
          ), 
          fillColor: Colors.white,
          filled: true ,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30)
          )


        ),
      ),
    );
  }
}