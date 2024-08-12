import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GradientCircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double percent;
  const GradientCircularPercentIndicator({super.key,
   required this.radius, 
   required this.percent});

  @override
  Widget build(BuiCircularP) {
    return CircularPercentIndicator(
      
      radius: radius,
      lineWidth: 25.0,
      percent: percent,
      center: Text(
        "${(percent * 100).toStringAsFixed(0)}%",
        style: GoogleFonts.irishGrover(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2
        ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.grey.shade300,
        progressColor: Colors.orange,

    );
  }
}