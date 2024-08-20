
import 'package:first_project_app/customWidgets/customtextfield.dart';
import 'package:first_project_app/customWidgets/custsnackbar.dart';
import 'package:first_project_app/customWidgets/tasks/custdropdown.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/task/add_task.dart';
import 'package:first_project_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditTask extends StatefulWidget {
  TaskModel taskindex;
  int  key1;
   
   EditTask({
    super.key,
    required this.key1,
    required this.taskindex
    });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
late TimeOfDay dateTime = TimeOfDay.now();
UserModel? currentUser;

dynamic selectedValueCategory;
final formKey = GlobalKey<FormState>();

List<String> listcategory =[];
List<String> emptyList=["No Category Added"];

final titleController = TextEditingController();
final taskTypeController = TextEditingController();
final dateController =TextEditingController();
final startTimeController = TextEditingController();
final endTimeController = TextEditingController();
final taskNoteController = TextEditingController();

bool? reminderOn;
ValueNotifier<bool> reminderNotifier2 = ValueNotifier(false);


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.taskindex.Tasktitle ?? '';
    taskTypeController.text = widget.taskindex.taskType ?? '';
    dateController.text = widget.taskindex.date ?? '';
    startTimeController.text = widget.taskindex.startTime ?? '';
    endTimeController.text = widget.taskindex.endTime ?? '';
    taskNoteController.text = widget.taskindex.taskNote ?? '';

    reminderOn = widget.taskindex.reminder;
    initializeUser().then((user){
      setState(() {
       currentUser = user; 
      });
    });

    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.orange,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                )),
                pinned: true,
                title: Text("Edit Task",
                style: GoogleFonts.irishGrover(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white
                ),),
                expandedHeight: 100,
                centerTitle: true,
          ),

          SliverFillRemaining(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),

              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SingleChildScrollView(
                    child:Padding(
                    
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Task Title',
                                style: GoogleFonts.irishGrover()),
                          ),

                          CustomTextField(
                            hintText: "Enter your title here!", 
                            customController: titleController,
                            mode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              final trimmedValue = value?.trim();
                              if(trimmedValue == null || trimmedValue.isEmpty){
                                return "Title Can't be empty";
                              }else{
                                return null;
                              }
                            },
                            ),


                            Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Category',
                                style:GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ), ),
                          ),


                          ValueListenableBuilder(
                            valueListenable: currentUserCategoryNotifier,
                            builder: (context, value, child) {
                              if (value.isEmpty) {
                                return CustomDropDownButton(
                                    onChanged: (value) {}, items: emptyList);
                              } else {
                                listcategory.clear();
                                for (var element in value) {
                                  listcategory.add(element.categoryTitle);
                                }
                                selectedValueCategory ??= listcategory.first;

                                return CustomDropDownButton(
                                    controller: taskTypeController,
                                    selectedValue: selectedValueCategory,
                                    onChanged: (dynamic newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedValueCategory = newValue;
                                          taskTypeController.text =
                                              selectedValueCategory;
                                        });
                                      }
                                    },
                                    items: listcategory);
                              }
                            },
                          ),


                               Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Date',
                                style:GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ), ),
                          ),


                           CustomTextField(
                            hintText: "Choose Date", 
                            customController: dateController,
                            maxLines: 1,
                            mode: AutovalidateMode.always,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "date can't be empty";
                              }else if(!isValidDateFormat(
                                dateController.text.trim()
                              )){
                                return "Please enter a valid date format";
                              }else{
                                DateTime? selectedDate = DateTime.tryParse(
                                  dateController.text.trim());
                                  if(selectedDate != null &&
                                  selectedDate.isBefore(DateTime.now()
                                  .subtract(const Duration(days: 1)))){
                                    return "Choose an upcoming date or todays date";
                                  }
                                  return null;
                              }
                            },
                            icon: IconButton(onPressed: () {
                              datePicker();
                              
                            }, icon: Icon(
                              Icons.calendar_today_rounded,
                            size: 18,
                            )),
                            ),


                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      
                                      
                                      Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Start Time',
                                style:GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ), ),
                          ),


                          CustomTextField(
                            hintText: "Choose Time",
                            maxLines: 1,
                            customController: startTimeController,
                            mode: AutovalidateMode.always,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Set Starting Time";
                              }else if(!isValidTimeFormat(
                                startTimeController.text.trim()))
                              {
                                return "Please enter a valid time Format(HH:mm)";
                              }
                              else{
                                DateTime? selectedDate = DateTime.tryParse(dateController.text.trim());
                                DateTime today = DateTime.now();
                                DateTime todayWithoutTime = DateTime(today.year,today.month,today.day);

                                String time = value.trim();
                                List parts = time.split(' ');
                                List timeParts = parts[0].split(':');
                                int hour = int.parse(timeParts[0]);
                                int minutes = int.parse(timeParts[1]);
                                String period = parts[1];
                                if(period == "PM" && hour != 12){
                                  hour += 12;
                                }
                                TimeOfDay pickedTime = TimeOfDay(hour: hour, minute: minutes);
                                if(selectedDate != null &&
                                selectedDate.isAtSameMomentAs(todayWithoutTime)&& 
                                pickedTime.hour <= DateTime.now().toLocal().hour &&
                                pickedTime.minute <= DateTime.now().toLocal().minute
                                
                                ){
                                  return "Choose an upcoming time";
                                }
                                return null;
                              }
                            },
                            icon: IconButton(onPressed: ()async {
                              await timePicker();
                              
                            }, icon: Icon(Icons.watch_later_outlined,)),
                            ),

                            


                           

                                  ],
                                )),


                                SizedBox(width: 30,),

                                Expanded(
                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('End Time',
                                style:GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ), ),
                          ),


                          CustomTextField(
                            
                            hintText: "Choose Time", 
                            customController: endTimeController,
                            enabled: true,
                            mode: AutovalidateMode.onUserInteraction,
                            maxLines: 1,
                            validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please pick \nend time';
                                          }
                                          if (!isValidTimeFormat(value)) {
                                            return 'Please enter a valid \ntime format (HH:mm)';
                                          } else {
                                            String startTimeString =
                                                startTimeController.text.trim();
                                            List startTimeParts =
                                                startTimeString.split(' ');
                                            List startTimeValues =
                                                startTimeParts[0].split(':');
                                            int startHour =
                                                int.parse(startTimeValues[0]);
                                            int startMinute =
                                                int.parse(startTimeValues[1]);
                                            String startPeriod =
                                                startTimeParts[1]; // AM or PM
                                            if (startPeriod == "PM" &&
                                                startHour != 12) {
                                              startHour += 12;
                                            }

                                            String endTimeString =
                                                endTimeController.text.trim();
                                            List endTimeParts =
                                                endTimeString.split(' ');
                                            List endTimeValues =
                                                endTimeParts[0].split(':');
                                            int endHour =
                                                int.parse(endTimeValues[0]);
                                            int endMinute =
                                                int.parse(endTimeValues[1]);
                                            String endPeriod =
                                                endTimeParts[1]; // AM or PM
                                            if (endPeriod == "PM" &&
                                                endHour != 12) {
                                              endHour += 12;
                                            }

                                            // Convert start and end times to TimeOfDay objects
                                            TimeOfDay startTime = TimeOfDay(
                                                hour: startHour,
                                                minute: startMinute);
                                            TimeOfDay endTime = TimeOfDay(
                                                hour: endHour,
                                                minute: endMinute);

                                            // Compare start and end times
                                            if (startTime.hour > endTime.hour ||
                                                (startTime.hour ==
                                                        endTime.hour &&
                                                    startTime.minute >=
                                                        endTime.minute)) {
                                              return 'End time should be \nafter start time';
                                            }
                                            return null;
                                          }
                                        },
                                        icon: IconButton(onPressed: () async{
                                          timePickerEnd();
                                          
                                        }, icon: Icon(Icons.watch_later_outlined,)),
                            )
                                    
                                  ],
                                ))
                              ],
                            ),

                               Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Task Note',
                                style:GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ), ),
                          ),

                        CustomTextField(
                          hintText: "Enter description here", 
                          customController: taskNoteController,
                          maxLines: 5,
                          ),

                          ValueListenableBuilder(
                            valueListenable: reminderNotifier, 
                            builder: (context, value, child) {
                              return Padding(padding: EdgeInsets.only(
                                top: 30,
                                bottom: 10,
                              ),
                              child:ElevatedButton(
                                onPressed: () async{
                                  reminderNotifier.value = !reminderNotifier.value;
                                  reminderOn = !reminderOn!;
                                }, 

                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: reminderOn == true
                                        ? Colors.orange
                                        : Colors.black,
                                        width: 1
                                      )
                                    )
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                    reminderOn == true
                                    ? Colors.orange
                                    : Colors.white
                                  )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        reminderOn == true
                                        ? "Reminder is On"
                                        : "Set Reminder",

                                        style: GoogleFonts.irishGrover(
                                          color: reminderOn == true
                                          ? Colors.white
                                          : Colors.black,

                                          fontWeight: FontWeight.bold
                                        ),

                                        ),

                                        SizedBox(width: 20,),

                                        Icon(
                                          reminderOn == true
                                          ? Icons.notifications_active
                                          : Icons.notifications_none,
                                          color: reminderOn == true
                                          ? Colors.white
                                          : Colors.black,
                                          
                                          )
                                    ],
                                  ),
                                  ),) ,
                              );
                            },),


                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: SizedBox( 
                                child: ElevatedButton(
                                    onPressed: () async {
  if (reminderOn == true) {
    try {
      DateTime pickedDate = DateTime.parse(dateController.text.trim());
      String time = startTimeController.text.trim();
      List parts = time.split(' ');
      List timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      String period = parts[1]; // AM or PM
      if (period == "PM" && hour != 12) {
        hour += 12;
      }
      TimeOfDay pickedTime = TimeOfDay(hour: hour, minute: minutes);
      await LocalNotificationService.showScheduledNotification(
        time: pickedTime,
        date: pickedDate,
        title: 'Hey ${currentUser?.userName ?? 'there'}, Don\'t forget about your task.',
        body: 'Title : ${titleController.text.trim()}\nGet it done now!'
      );
    } catch (e) {
      print('Error scheduling notification: $e');
      CustomSnackBar.show(context, 'Failed to set reminder');
    }
  }
  
  await updateTask(widget.key1);
},
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.orange,
                                      ),
                                      foregroundColor:
                                          MaterialStatePropertyAll(Colors.white),
                                      fixedSize: const MaterialStatePropertyAll(
                                        Size(380.0, 50.0),
                                      ),
                                    ),
                                    child:  Text(
                                      'Edit',
                                      style: GoogleFonts.irishGrover(fontSize: 20.0),
                                    )),
                              ))


                            








                            
                            ],

                          
                      ),
                    )
                  ),
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
Future<void> updateTask(int key1) async {
  if (!formKey.currentState!.validate()) {
    CustomSnackBar.show(context, 'Please fill all required fields correctly');
    return;
  }

  try {
    final Box<TaskModel> tasks = await Hive.openBox<TaskModel>('task_db');
    final TaskModel existingTask = tasks.get(key1)!;
    
    TaskModel taskModel = TaskModel(
      Tasktitle: titleController.text.trim(),
      date: dateController.text.trim(),
      startTime: startTimeController.text.trim(),
      endTime: endTimeController.text.trim(),
      taskNote: taskNoteController.text.trim(),
      taskType: taskTypeController.text.trim(),
      isImportant: existingTask.isImportant,
      iscompleted: existingTask.iscompleted,
      userKey: userKey,
      reminder: reminderOn
    );

    await TaskFunctions().editTask(taskModel, key1);
    
    Navigator.of(context).pop();
    CustomSnackBar.show(context, 'Task has been edited successfully');
  } catch (e, stackTrace) {
    print('Error updating task: $e');
    print('Stack trace: $stackTrace');
    CustomSnackBar.show(context, 'An error occurred while updating the task: ${e.toString()}');
  }
}
  void datePicker() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (pickDate != null) {
      setState(() {
        dateController.text = DateFormat('yyy-MM-dd').format(pickDate);
      });
    }
  }

  timePicker() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      startTimeController.text = time!.format(context);
    });
  }

  timePickerEnd() async {
    TimeOfDay? endTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      endTimeController.text = endTime!.format(context);
    });
  }

}
