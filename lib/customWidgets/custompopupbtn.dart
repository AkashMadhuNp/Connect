import 'package:first_project_app/class/menu_items.dart';
import 'package:flutter/material.dart';


class CustomPopUpButton extends StatelessWidget {
  final Color color;
  final List<MenuItems> items;
  const CustomPopUpButton(
      {super.key, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PopupMenuButton<MenuItems>(
        iconSize: width > 600 ? height * 0.05 : height * 0.035,
        iconColor: color,
        onSelected: (selectedItem) {
          selectedItem.onTap();
        },
        itemBuilder: (BuildContext context) {
          return items.map((MenuItems item) {
            return PopupMenuItem<MenuItems>(
              value: item,
              child: Row(
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  Text(item.title),
                ],
              ),
            );
          }).toList();
        });
  }
}
