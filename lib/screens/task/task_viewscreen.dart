
import 'package:first_project_app/customWidgets/events/eventview_row.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewTask extends StatelessWidget {
  final TaskModel taskIndex;

 const  ViewTask({
    super.key, 
    required this.taskIndex
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body:CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            expandedHeight: 100.0,
            leading: IconButton(onPressed: () {
              Navigator.of(context).pop();
              
            }, icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            ),
            pinned: true,
            title: Text("View Task", style: GoogleFonts.irishGrover(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
            ),
            ),
          ),

          SliverFillRemaining(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )
              ),
              child: SingleChildScrollView(
                child: ValueListenableBuilder(valueListenable: taskNotifier, 
                builder: (context, List<TaskModel> taskList, child_){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),

                      EventViewRow(
                        title: "Task Title", 
                        body: taskIndex.Tasktitle ?? ''),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        taskIndex.taskType != null && taskIndex.taskType!.isNotEmpty
                        ? EventViewRow(title: "Task Type", 
                        body: taskIndex.taskType ?? '')
                        : const SizedBox(),

                        taskIndex.taskType!=null && taskIndex.taskType!.isNotEmpty
                        ?const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ):const SizedBox(),

                        taskIndex.taskType != null && taskIndex.taskType!.isNotEmpty
                        ? Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ):const SizedBox(),

                        EventViewRow(title: "Date", body:taskIndex.date ?? ""),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        EventViewRow(title: "Start Time", 
                        body: taskIndex.startTime ?? ""),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        EventViewRow(
                          title: "End Time", 
                          body: taskIndex.endTime ?? " "),

                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),


                          taskIndex.taskNote != null && taskIndex.taskNote!.isNotEmpty
                          ? EventViewRow(title: "Task Note", 
                          body: ""):const SizedBox(),

                          taskIndex.taskNote != null && taskIndex.taskNote!.isNotEmpty
                          ? Padding(padding: EdgeInsets.all(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey
                              ),
                              gradient: LinearGradient(colors: [
                                Colors.yellow.shade300,
                                Colors.yellow.shade600,
                              ]),
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child: Padding(padding: EdgeInsets.all(8),
                            child: Text(taskIndex.taskNote ?? ""),
                            ),

                          ),
                          )
                          :const SizedBox()



                    ],
                  );
                } ,),
              ),
            ),

          )
          
        ],
      ) ,
    );
  }
}