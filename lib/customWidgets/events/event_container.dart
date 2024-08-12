// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class EventContainer extends StatelessWidget {
  Widget child;
 EventContainer({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 232, 203, 249),
                          Color.fromARGB(255, 252, 219, 205),
                        ],
                      )),
                      child: child,
                ),
    );
  }
}