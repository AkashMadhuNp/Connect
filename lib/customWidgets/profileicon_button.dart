import 'package:flutter/material.dart';

class ProfieIconBtn extends StatelessWidget {
  final VoidCallback onTap;
   ProfieIconBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 55,

        left: 74
      ),
      child: IconButton(
        onPressed: onTap, 
        icon:Icon(Icons.add_a_photo,size: 30.0,)),
    );
  }
}