
import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';


class TimeLine extends StatefulWidget {
  final int taskkey;
  final String startTime;
  final String endTime;
  final String tasktile;
  final String date;
  final VoidCallback onTap;
  final TaskModel taskModel;

  const TimeLine(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.tasktile,
      required this.taskModel,
      required this.taskkey,
      required this.date,
      required this.onTap});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  bool? valueChecked1;
  bool? valueChecked2;
  ValueNotifier checknotifier = ValueNotifier(false);
  ValueNotifier checknotifier2 = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    valueChecked1 = widget.taskModel.iscompleted;
    valueChecked2 = widget.taskModel.isImportant;
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    return TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.23,
        beforeLineStyle: LineStyle(
            color: valueChecked2 == true
                ? const Color.fromARGB(255, 191, 191, 252)
                : const Color.fromARGB(255, 210, 187, 221),
            thickness: 3),
        indicatorStyle: IndicatorStyle(
          width: 20,
          indicatorXY: 0.9,
          color: valueChecked2 == true
              ? const Color.fromARGB(255, 139, 139, 243)
              : const Color.fromARGB(255, 154, 124, 199),
        ),
        endChild: Padding(
          padding: EdgeInsets.only(
              left: 10 + padding.left,
              right: 15 + padding.right,
              bottom: 15 + padding.top),
          child: CustomTaskContainer(
              colors: valueChecked2 == true
                  ? [
                      const Color.fromARGB(255, 236, 228, 252),
                      const Color.fromARGB(255, 199, 199, 234)
                    ]
                  : [
                      const Color.fromARGB(255, 252, 219, 205),
                      const Color.fromARGB(255, 232, 203, 249),
                    ],
              border: valueChecked2 == true
                  ? Border.all(
                      width: 1, color: const Color.fromARGB(255, 114, 97, 222))
                  : null,
              decoration: valueChecked1 == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,subtitleDecoration: valueChecked1 == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              text: widget.tasktile,
              startTime: widget.startTime,
              endTime: widget.endTime,
              onTap: widget.onTap,
              widget: PopupMenuButton(onSelected: (value) {
                Navigator.of(context).pop();
              }, itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      checknotifier.value = !checknotifier.value;
                      valueChecked1 = !valueChecked1!;
                      await taskDone();
                    },
                    child: ValueListenableBuilder(
                        valueListenable: checknotifier2,
                        builder: (context, value, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('Mark as Done'),
                              const SizedBox(
                                width: 15,
                              ),
                              Icon(
                                valueChecked1!
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 20,
                                color: const Color.fromARGB(255, 90, 72, 147),
                              )
                            ],
                          );
                        }),
                  ),
                  PopupMenuItem(
                      onTap: () async {
                        checknotifier.value = !checknotifier.value;

                        valueChecked2 = !valueChecked2!;
                        await taskDone();
                      },
                      child: ValueListenableBuilder(
                          valueListenable: checknotifier,
                          builder: (context, value, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Mark as Important'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  valueChecked2!
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 24,
                                  color: const Color.fromARGB(255, 90, 72, 147),
                                )
                              ],
                            );
                          })),
                ];
              })),
        ),
        startChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.startTime,
                  style: TextStyle(
                      decoration: valueChecked1 == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: valueChecked2 == true
                          ? const Color.fromARGB(255, 81, 56, 240)
                          : Colors.purple)),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.endTime,
                style: TextStyle(
                    decoration: valueChecked1 == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: valueChecked2 == true
                        ? const Color.fromARGB(255, 81, 56, 240)
                        : Colors.purple),
              )
            ],
          ),
        ));
  }

  Future taskDone() async {
    TaskModel taskModel = TaskModel(
        Tasktitle: widget.taskModel.Tasktitle,
        date: widget.taskModel.date,
        startTime: widget.taskModel.startTime,
        endTime: widget.taskModel.endTime,
        reminder: widget.taskModel.reminder,
        repeat: widget.taskModel.repeat,
        taskNote: widget.taskModel.taskNote,
        taskType: widget.taskModel.taskType,
        isImportant: valueChecked2,
        iscompleted: valueChecked1,
        userKey: userKey);
    await TaskFunctions().editTask(
      taskModel,
      widget.taskkey,
    );
  }
}
