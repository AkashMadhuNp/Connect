


import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ValueNotifier<List<TaskModel>> taskNotDoneNotifier = ValueNotifier([]);

class TaskNotDone extends StatefulWidget {
  const TaskNotDone({Key? key}) : super(key: key);

  @override
  _TaskNotDoneState createState() => _TaskNotDoneState();
}

class _TaskNotDoneState extends State<TaskNotDone> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when the widget is first created
    TaskFunctions().getTaskNotDone();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskNotDoneNotifier,
      builder: (context, List<TaskModel> taskNotDoneList, child) {
        if (taskNotDoneList.isNotEmpty) {
          return ListView.builder(
            itemCount: taskNotDoneList.length,
            itemBuilder: (context, index) {
              return CustomTaskContainer(
                text: taskNotDoneList[index].Tasktitle!,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewTask(taskIndex: taskNotDoneList[index]),
                  ));
                },
                colors: const [
                  Color.fromARGB(255, 252, 219, 205),
                  Color.fromARGB(255, 232, 203, 249)
                ],
                widget: Text(taskNotDoneList[index].date ?? '',style: GoogleFonts.irishGrover(),),
                startTime: taskNotDoneList[index].startTime ?? '',
                endTime: taskNotDoneList[index].endTime ?? '',
              );
            },
          );
        } else {
          return EmptyEvent(
            text: "There is no task to do. \n You have done everything",
          );
        }
      },
    );
  }
}