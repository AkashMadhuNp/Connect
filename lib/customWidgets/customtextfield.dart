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

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.enabled,
    this.mode,
    required this.customController,
    this.icon,
    this.validator,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;
    
    // Calculate responsive width
    //final double fieldWidth = size.width > 600 ? 400 : size.width * 0.8;
    
    return SizedBox(
      //width: fieldWidth,
      child: TextFormField(
        enabled: enabled,
        autovalidateMode: mode,
        maxLines: maxLines,
        controller: customController,
        validator: validator,
        style: GoogleFonts.irishGrover(fontSize: size.width > 600 ? 16 : 14),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: icon,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.irishGrover(fontSize: size.width > 600 ? 16 : 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width > 600 ? 25 : 20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(size.width > 600 ? 25 : 20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width > 600 ? 25 : 20),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: size.width > 600 ? 16 : 12,
            horizontal: size.width > 600 ? 20 : 16,
          ),
        ),
      ),
    );
  }
}