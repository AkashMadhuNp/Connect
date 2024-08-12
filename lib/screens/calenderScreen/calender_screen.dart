import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/calenderScreen/custom_calender.dart';
import 'package:first_project_app/screens/calenderScreen/timeline.dart';
import 'package:first_project_app/screens/task/edit_task.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> currentUserTasksNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> currentUserTaskOnSelecteDdayNotifier =
    ValueNotifier([]);
DateTime today = DateTime.now();

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({
    super.key,
  });

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTablecalender(
          onDayselected: (DateTime day, DateTime focusedDay) async {
            setState(() {
              today = day;
            });
            await TaskFunctions().getCurrentUsertaskOnSelectedDay(day);
          },
          fun: (day) => isSameDay(today, day),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: currentUserTaskOnSelecteDdayNotifier,
            builder: (BuildContext context, List<TaskModel> taskList, child_) {
              if (taskList.isEmpty) {
                return Column(
                  children: [
                     SvgPicture.asset(
                        'assets/donetask.svg',
                        height: 100,
                        width: 100,
                      ),
                    
                     Text(
                        'no tasks for the day.\nClick + to create your tasks',
                        style: GoogleFonts.irishGrover(),
                        ),
                  ],
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = taskList[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                              borderRadius: BorderRadius.circular(30),
                              icon: Icons.delete_rounded,
                              backgroundColor: Colors.yellow.shade100,
                              foregroundColor: Colors.red,
                              onPressed: (context) async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertBox(
                                        okText: 'Delete',
                                        text:
                                            'Are you sure you want to delete this task?',
                                        title: 'Delete Task?',
                                        onpressedCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onpressedDelete: () async {
                                          await TaskFunctions()
                                              .delete(taskList[index].key!)
                                              .then((value) =>
                                                  Navigator.of(context).pop());
                                        });
                                  },
                                  
                                );
                              }),
                          SlidableAction(
                              icon: Icons.mode_edit_rounded,
                              backgroundColor: Colors.yellow.shade100,
                              foregroundColor: Colors.black,
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                                EditTask(
                                  key1: taskList[index].key, 
                                  taskindex: taskList[index]),));
                              },
                          )
                        ],
                      ),
                      key: ValueKey(data),
                      child: TimeLine(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewTask(taskIndex: data)));
                        },
                        date: data.date ?? '',
                        taskkey: taskList[index].key ?? UniqueKey().hashCode,
                        taskModel: data,
                        startTime: data.startTime ?? '',
                        endTime: data.endTime ?? '',
                        tasktile: data.Tasktitle ?? '',
                      ),
                      // ),
                    );
                  },
                  itemCount: taskList.length,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  initialize() async {
    return await TaskFunctions().getCurrentUsertaskOnSelectedDay(today);
  }
}
