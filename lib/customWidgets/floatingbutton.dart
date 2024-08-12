
import 'package:first_project_app/customWidgets/floatingview.dart';
import 'package:first_project_app/screens/event/addevent.dart';
import 'package:first_project_app/screens/task/add_task.dart';
import 'package:flutter/material.dart';

class CustomFloating extends StatelessWidget {
  const CustomFloating({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingView(
            icon: Icons.task,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskPage(),));
             },
             text: "Add Task",),

             const Divider(),

             FloatingView(icon: Icons.event, text: "Add Event",onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEvents(),));
               
             },)

        ],
      ),


    );
  }
}