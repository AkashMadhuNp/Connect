import 'package:flutter/material.dart';

class ScreenOn extends StatelessWidget {
  const ScreenOn({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/conlogo-removebg-preview.png',height: height*0.5,width: width,)
        ],
      ),

    );
  }
}