import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ValueNotifier<List<TaskModel>> taskDoneNotifier = ValueNotifier([]);

class TaskDone extends StatelessWidget {
  const TaskDone({super.key});

  @override
  Widget build(BuildContext context) {
    TaskFunctions().getTaskDone();
    return ValueListenableBuilder(
      valueListenable: taskDoneNotifier,
      builder: (
        BuildContext context, 
        List<TaskModel> taskDoneList, child_) {
        if(taskDoneList.isNotEmpty){
          return ListView.builder(
            itemBuilder: (context, index) {
              return CustomTaskContainer(
                text: taskDoneList[index].Tasktitle!, 
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewTask(taskIndex: taskDoneList[index],),),
                  );
                }, 
                colors: const[
                 
                Color.fromARGB(255, 252, 219, 205),
                 Color.fromARGB(255, 232, 203, 249)
                ], 
                widget: Text(taskDoneList[index].date?? '',style: GoogleFonts.irishGrover(),),
                startTime: taskDoneList[index].startTime ?? '', 
                endTime:taskDoneList[index].endTime ?? '', 
              );
            },
            itemCount: taskDoneList.length,
          );
        } else {
          return const EmptyEvent(text: "You haven't done any task yet");
        }
      },
    );
  }
}