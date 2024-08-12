


import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';

class Taskimportant extends StatelessWidget {
  const Taskimportant({super.key});

  @override
  Widget build(BuildContext context) {
    TaskFunctions().getTaskImportant();
    return ValueListenableBuilder(
      valueListenable: taskImportantNotifier,

      builder: ((BuildContext context, List<TaskModel> taskDoneList,child_){
        if(taskDoneList.isNotEmpty){
          return ListView.builder(itemBuilder: (context, index) {
            return CustomTaskContainer(
              text: taskDoneList[index].Tasktitle!, 
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => 
                  ViewTask(taskIndex: taskDoneList[index]),));
              }, 
              colors:const  [
                  Color.fromARGB(255, 252, 219, 205),
                  Color.fromARGB(255, 232, 203, 249),
                ],
                widget: Text(taskDoneList[index].date ?? ''),
              startTime: taskDoneList[index].startTime ?? '', 
              endTime: taskDoneList[index].endTime ?? ''
              );
            
          },
          itemCount: taskDoneList.length,
          );
        }else{
          return EmptyEvent(text: "No Important task has been marked");
        }
        
      }),
    );
  }
}