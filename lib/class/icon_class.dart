import 'package:flutter/material.dart';

class IconItem{
  final IconData icon;
  final Color color;

  IconItem({
    required this.icon,
    required this.color
  });
}

List<IconItem> icons =[
   IconItem(icon: Icons.person_2_rounded, color: Colors.black),
  IconItem(icon: Icons.monitor_heart_rounded, color:  Colors.black),
  IconItem(icon: Icons.location_on_outlined, color:  Colors.black),
  IconItem(icon: Icons.work_rounded, color:  Colors.black),
  IconItem(icon: Icons.shopping_cart, color:  Colors.black),
  IconItem(icon: Icons.home_work, color:  Colors.black),
  IconItem(icon: Icons.cake, color:  Colors.black),
  IconItem(icon: Icons.food_bank_rounded, color:  Colors.black),
  IconItem(icon: Icons.campaign_sharp, color:  Colors.black),
  IconItem(icon: Icons.card_giftcard_rounded, color:  Colors.black),
  IconItem(icon: Icons.play_circle_fill_outlined, color:  Colors.black),
  IconItem(icon: Icons.time_to_leave_sharp, color:  Colors.black),
  IconItem(icon: Icons.punch_clock_sharp, color:  Colors.black),
];