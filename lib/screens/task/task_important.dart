


import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                // widget: Text(taskDoneList[index].date ?? '',style: GoogleFonts.irishGrover(),),

                widget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      taskDoneList[index].date ?? '',
                      style: GoogleFonts.irishGrover(),
                    ),
                    IconButton(
                      icon: Icon(Icons.star, color: Colors.purple[700]),
                      onPressed: () async {
                        bool? confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Unmark as Important',
                              style: GoogleFonts.irishGrover(
                                fontWeight: FontWeight.bold,

                              ),),
                              content: Text('Are you sure you want to unmark this task as important?',style:GoogleFonts.irishGrover(
                                fontWeight: FontWeight.normal
                              ),),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel',style: GoogleFonts.irishGrover(),),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text(
                                    'Unmark',
                                    style: GoogleFonts.irishGrover(
                                      color: Colors.red
                                      )),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          TaskModel updatedTask = taskDoneList[index];
                          updatedTask.isImportant = false;
                          await TaskFunctions().editTask(updatedTask, updatedTask.key!);
                          TaskFunctions().getTaskImportant();
                        }
                      },
                    ),
                  ],
                ),
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