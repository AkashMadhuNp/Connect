import 'dart:io';
import 'dart:typed_data';
import 'package:first_project_app/class/menu_items.dart';
import 'package:first_project_app/customWidgets/custompopupbtn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Usercontainer extends StatelessWidget {
  final String text;
  final String img;
  final List<MenuItems> items;
  final Color color;

  const Usercontainer({
    Key? key, 
    required this.text, 
    required this.img, 
    required this.color, 
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8),
      height: 250,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 110, 100, 117).withOpacity(0.5),
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade300,
            const Color.fromARGB(255, 237, 217, 37),
            Colors.orange.shade400
          ],
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
                SizedBox(width: 150),
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
              child: _buildProfileImage(),
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

  Widget _buildProfileImage() {
    if (img.isEmpty) {
      return const CircleAvatar(
        backgroundImage: AssetImage("assets/profile_icon.jpg"),
      );
    }

    if (kIsWeb) {
      final Uint8List? imageData = webImageStore[img];
      if (imageData != null) {
        return CircleAvatar(
          backgroundImage: MemoryImage(imageData),
        );
      } else {
      
        return const CircleAvatar(
          backgroundImage: AssetImage("assets/profile_icon.jpg"),
        );
      }
    } else {
      
      return CircleAvatar(
        backgroundImage: FileImage(File(img)),
      );
    }
  }
}


Map<String, Uint8List> webImageStore = {};