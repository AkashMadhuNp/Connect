import 'package:flutter/material.dart';

class MenuItems{
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItems({
    required this.title,
    required this.icon,
    required this.onTap
  });

}