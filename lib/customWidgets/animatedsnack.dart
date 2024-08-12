import 'package:flutter/material.dart';

class CustomAnimatedPopup extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color color;

  const CustomAnimatedPopup({
    Key? key,
    required this.message,
    required this.icon,
    required this.color,
  }) : super(key: key);

  static void show(BuildContext context, String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAnimatedPopup(
          message: message,
          icon: isError ? Icons.error : Icons.check_circle,
          color: isError ? Colors.red : Colors.green,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: color),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: color
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}