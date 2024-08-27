import 'package:first_project_app/customWidgets/customtextfield.dart';
import 'package:first_project_app/customWidgets/custsnackbar.dart';
import 'package:first_project_app/customWidgets/tasks/custdropdown.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/home/home_nav.dart';
import 'package:first_project_app/services/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

ValueNotifier<bool>
 reminderNotifier = ValueNotifier(false);
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  UserModel? currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeUser().then((user){
      setState(() {
        currentUser = user;
      });
    });
  }

  late TimeOfDay dateTime = TimeOfDay.now();
  List<String> listcategory=[];
  List<String> emptyList =['No Category added'];

  dynamic selectedValueCategory;
    final formKey = GlobalKey<FormState>();


   final titleController = TextEditingController();
  final taskTypeController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endtimeController = TextEditingController();
  final reminderController = TextEditingController();
  final repeatController = TextEditingController();
  final taskNoteController = TextEditingController();

  bool? reminderOn = false;

  bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 600; // Adjust
}


  

  


  @override
  Widget build(BuildContext context) {
    CategoryFunction().currentUserCategory(userKey!);
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            expandedHeight: 100,
            leading: IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNavPage(),));
            }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 20,)),
            pinned: true,
            title: Text("Add Task",style: GoogleFonts.irishGrover(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2
            ),),

          ),
          SliverFillRemaining(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                    padding:EdgeInsets.only(top: 8) ,
                    child: SingleChildScrollView(
                      child: Padding(padding: EdgeInsets.only(
                        left: 30,right: 30
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.only(
                            left: 20,
                            top: 10,
                            bottom: 10
                          ),
                          child: Text("Task Title",style: GoogleFonts.irishGrover(
                            color: Colors.black,
                            fontSize: 20
                          ),),

                          ),

                          CustomTextField(
                            mode: AutovalidateMode.onUserInteraction,
                            hintText: "Enter your title here!", 
                            customController: titleController,
                             validator: (value) {
                              final trimmedValue = value?.trim();
                              if (trimmedValue == null ||
                                  trimmedValue.isEmpty) {
                                return 'Title Can\'t be empty';
                              } else {
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
                              if(value.isEmpty){
                                return SizedBox(
                                 // width: 350,
                                  child: CustomDropDownButton(
                                    onChanged: (value){}, 
                                    items: emptyList),
                                );
                              }else{
                                listcategory.clear();
                                for(var element in value){
                                  listcategory.add(element.categoryTitle);
                                }
                                selectedValueCategory ??=listcategory.first;


                                return CustomDropDownButton(
                                  controller: taskTypeController,
                                  selectedValue: selectedValueCategory,
                                  onChanged: (dynamic newvalue) {
                                    if(newvalue!=null){
                                      setState(() {
                                        selectedValueCategory=newvalue;
                                        taskTypeController.text = 
                                        selectedValueCategory;
                                      });
                                    }
                                    
                                  }, items:listcategory);
                              }
                            } ,),


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
                            mode: AutovalidateMode.onUserInteraction,
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
                                  selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))){
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
                            mode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Set Starting Time";
                              }else if(!isValidTimeFormat(startTimeController.text.trim()))
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

                                Expanded(child: Column(
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
                            customController: endtimeController,
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
                                                endtimeController.text.trim();
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
                                bottom: 10
                              ),
                              child: SizedBox(
                                
                                child: ElevatedButton(
                                  onPressed: () async {
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
                                      :Colors.white
                                      )
                                  ),
                                
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(reminderOn == true
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
                                          : Colors.black
                                        )
                                      ],
                                    ),
                                  
                                  ),
                                ),
                              ),
                              );
                            },),



                          Padding(padding: EdgeInsets.only(top: 20,bottom: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              
                              style: ButtonStyle(
                                backgroundColor:MaterialStatePropertyAll(Colors.orange)
                              ),
                              onPressed: ()async{
                                if (reminderOn == true) {
                                        DateTime pickedDate = DateTime.parse(
                                            dateController.text.trim());
                                        String time =
                                            startTimeController.text.trim();
                                        List parts = time.split(' ');
                                        List timeParts = parts[0].split(':');
                                        int hour = int.parse(timeParts[0]);
                                        int minutes = int.parse(timeParts[1]);
                                        String period = parts[1]; // AM or PM
                                        if (period == "PM" && hour != 12) {
                                          hour += 12;
                                        }
                                        TimeOfDay pickedTime = TimeOfDay(
                                            hour: hour, minute: minutes);
                                        await LocalNotificationService
                                            .showScheduledNotification(
                                                time: pickedTime,
                                                date: pickedDate,
                                                title:
                                                    'Hey ${currentUser?.userName ?? 'there'}, Don\'t forget about your task.',
                                                body:
                                                    'Title : ${titleController.text.trim()}\nGet it done now!');
                                      }
                                await onAddTaskButtonClicked();
                              
                            }, child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Save",style: GoogleFonts.irishGrover(color: Colors.white,fontSize: 24),),
                            )),
                          ),
                          )





                        ],
                      ),
                      
                      ),
                    ),
                    )),
                
              ),
            ),
          )
        ],
      ),
    );
  }


     Future<void> onAddTaskButtonClicked() async {
    try {
      String? currentUserKey = await UserFunctions().getCurrentUserKey();

      final _taskTitle = titleController.text.trim();
      final _date = dateController.text.trim();
      final _startTime = startTimeController.text.trim();
      final _endTime = endtimeController.text.trim();
      final _taskNote = taskNoteController.text.trim();
      final _taskType = taskTypeController.text.trim();

      if (formKey.currentState!.validate()) {
        TaskModel task = TaskModel(
          Tasktitle: _taskTitle,
          date: _date,
          startTime: _startTime,
          endTime: _endTime,
          reminder: reminderOn,
          taskNote: _taskNote,
          taskType: _taskType,
          isImportant: false,
          iscompleted: false,
          userKey: currentUserKey,
        );

        await TaskFunctions().addTask(task);
        
        // Refresh tasks for the current day
        await TaskFunctions().getCurrentUsertaskOnSelectedDay(DateTime.parse(_date));
        
        // Schedule notification if reminder is on
        if (reminderOn == true) {
          DateTime pickedDate = DateTime.parse(_date);
          List timeParts = _startTime.split(' ');
          List timeValues = timeParts[0].split(':');
          int hour = int.parse(timeValues[0]);
          int minutes = int.parse(timeValues[1]);
          String period = timeParts[1]; // AM or PM
          if (period == "PM" && hour != 12) {
            hour += 12;
          }
          TimeOfDay pickedTime = TimeOfDay(hour: hour, minute: minutes);
          
          await LocalNotificationService.showScheduledNotification(
            time: pickedTime,
            date: pickedDate,
            title: 'Hey ${currentUser?.userName ?? 'there'}, Don\'t forget about your task.',
            body: 'Title: $_taskTitle\nGet it done now!'
          );
        }

        CustomSnackBar.show(context, 'New task has been successfully added');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeNavPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all required fields'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add task. Please try again later.'),
      ));
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
      endtimeController.text = endTime!.format(context);
    });
  }
}

  bool isValidTimeFormat(String value) {
  RegExp timeRegex = RegExp(r'^((1[0-2]|0?[1-9]):([0-5]\d) ([AP]M))$');
  return timeRegex.hasMatch(value);
}


  bool isValidDateFormat(String value) {
  RegExp dateRegex = RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');
  return dateRegex.hasMatch(value);
}
  initializeUser() async {
  return await UserFunctions().getCurrentUser(userKey!);
}
