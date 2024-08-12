import 'dart:io';
import 'package:first_project_app/class/menu_items.dart';
import 'package:first_project_app/customWidgets/custompopupbtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Usercontainer extends StatelessWidget {
  final String text;
  final String img;
  final List<MenuItems> items;
  final Color color;

  const Usercontainer({super.key, required this.text, required this.img, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),  // Added padding
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 110, 100, 117).withOpacity(0.5),
            blurRadius: 7,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade300,
            Color.fromARGB(255, 237, 217, 37),
            Colors.orange.shade400
          ],
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 150,),
                
                CustomPopUpButton(items: items, color: Colors.black)
              ],
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: img == ''
                  ? const CircleAvatar(
                      backgroundImage: AssetImage("assets/profile_icon.jpg"),
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(File(img)),
                    ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 270,
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.irishGrover(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
