import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final TextEditingController? controller;

  const CustomDropDownButton({
    super.key,
    this.selectedValue,
    required this.onChanged,
    required this.items,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black,),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                onChanged(newValue);
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
            ),
          ),
        ),
      ),
    );
  }
}