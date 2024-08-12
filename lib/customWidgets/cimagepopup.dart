import 'package:flutter/material.dart';

class ImagePopUp extends StatelessWidget {
  final Widget child2;
  final Widget child;
  final bool condition;
   ImagePopUp({super.key,
   required this.condition, 
   required this.child2, 
   required this.child
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        condition == true
        ? showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                child: child2,
              ),
            );
          },
          ):null;
      },
      child: child,
    );
  }
}