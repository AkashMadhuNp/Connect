import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/custm_timeline.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/screens/calenderScreen/custom_calender.dart';
import 'package:first_project_app/screens/task/edit_task.dart';
import 'package:first_project_app/screens/task/task_viewscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> filteredCategoryNotifier = ValueNotifier([]);

// ignore: must_be_immutable
class ViewCategory extends StatefulWidget {
  final int? taskKey;
  String category;
   ViewCategory({
    super.key, 
   this.taskKey,
   required this.category
   });

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  DateTime todayy = DateTime.now();
  bool showFullText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
            backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios)),
          title: GestureDetector(
            onTap: () {
              setState(() {
                showFullText = !showFullText;
                
              });

            },
            child: Text(widget.category,
            style: GoogleFonts.irishGrover(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              
            ),

            overflow: showFullText == true? null: TextOverflow.ellipsis,
            ),
          ),
      ),


      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.yellow.shade100
        ),
        child: Column(
          children: [
            CategoryTablecalender(
              onDayselected: (DateTime dayy, DateTime focusedDay)async{
                setState(() {
                  todayy = dayy;
                });
                await CategoryFunction().filterTaskByCategoryOnThisDay(dayy);
              } , 
              fun: (dayy) =>isSameDay(todayy, dayy) 
              ,),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: filterTaskByCategoryOnThisDayNotifier, 
                  builder: (context, valueList, child) {
                    initializeTask();
                    if(valueList.isEmpty){
                      return const Center(
                        child: EmptyEvent(
                          text: 'No task has been scheduled',
                          
                          ),
                      );
                    }else{
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (context, index) {
                        var keyValue = valueList[index].key;

                        TaskModel modelValue = valueList[index];
                        bool valueChecked1 = valueList[index].iscompleted ?? false;
                        bool valueChecked2 = valueList[index].isImportant ?? false;
                        ValueNotifier checknotifier = ValueNotifier(valueChecked1);
                        ValueNotifier checknotifier2 = ValueNotifier(valueChecked2);


                        return Padding(
                          padding: EdgeInsets.only(left: 10,right: 15),
                          child: NewCustomTimeLine(
                           
                             
                            
                            
                            
                            subtitleDecoration: valueChecked1 == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                            border: valueChecked2 == true
                            ? Border.all(
                              width: 1,
                              color: Colors.blue
                            ):null,



                             colors: valueChecked2 == true
                             ? [
                                      const Color.fromARGB(255, 236, 228, 252),
                                      const Color.fromARGB(255, 199, 199, 234)
                                    ]
                                  : [
                                      const Color.fromARGB(255, 252, 219, 205),
                                      const Color.fromARGB(255, 232, 203, 249),
                                    ],

                                     lineColor:  valueChecked2 == true
                                  ? const Color.fromARGB(255, 191, 191, 252)
                                  : const Color.fromARGB(255, 210, 187, 221),

                                  indicatorColor:valueChecked2 == true
                                   ? const Color.fromARGB(255, 139, 139, 243)
                                  : const Color.fromARGB(255, 154, 124, 199),

                                  textColor: valueChecked2 == true
                                  ? const Color.fromARGB(255, 81, 56, 240)
                                  : Colors.purple,

                                  onPressed1: (value){
                                    showDialog(
                                      context: context, 
                                      builder: (context) {
                                        return CustomAlertBox(
                                          text: "Are you sure you want to delete this task?",
                                           title:"Delete Task ?", 
                                           onpressedCancel: () {
                                             Navigator.of(context).pop();
                                           }, 
                                           onpressedDelete:() async{
                                            await TaskFunctions().delete(valueList[index].key!).then((value)=>Navigator.of(context).pop());
                                             
                                           }, okText: "Delete"
                                           );
                                      },);
                                  },



                                  onPressed2: (value) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                                    EditTask(
                                      key1: valueList[index].key, 
                                      taskindex: valueList[index]),))
                                      .then((value)async{
                                        await TaskFunctions().getAllTAsk();
                                        await initializeTask();
                                        filterTaskByCategoryOnThisDayNotifier.notifyListeners();

                                      });
                                    
                                  },


                                  onTap:(){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ViewTask(taskIndex: valueList[index]),)
                                    );
                                  },

                                  onItem1: ()async{
                                    valueChecked1 = !valueChecked1;
                                    checknotifier.value = valueChecked1;
                                    await taskDone(
                                      modelValue, 
                                      keyValue, 
                                      modelValue.taskType!, 
                                      valueChecked1, 
                                      valueChecked2
                                      );
                                      await initializeTask();
                                  },

                                  item1: ValueListenableBuilder(
                                    valueListenable: checknotifier, 
                                    builder: (context, value, child) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("Mark as Done",style: GoogleFonts.irishGrover(),),
                                          SizedBox(width: 15,),
                                          Icon(
                                            modelValue.iscompleted!
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                            size: 20,
                                            color: const Color.fromARGB(
                                            255, 90, 72, 147),
                                          )
                                        ],
                                      );
                                    },),

                                    onItem2: ()async {
                                        valueChecked2 =!valueChecked2;
                                        checknotifier2.value = valueChecked2;
                                        await taskDone(
                                          modelValue, 
                                          keyValue, 
                                          modelValue.taskType!, 
                                          valueChecked1, 
                                          valueChecked2
                                          );
                                          await initializeTask();
                                      
                                    },

                                    item2: ValueListenableBuilder(
                                      valueListenable: checknotifier2, 
                                      builder:(context, value, child) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text("Mark as Important",
                                            style: GoogleFonts.irishGrover(),
                                            ),
                                            SizedBox(width: 10,),
                                            Icon(
                                              modelValue.isImportant!
                                              ? Icons.star
                                              : Icons.star_border,
                                              size: 24,
                                              color: const Color.fromARGB(
                                            255, 90, 72, 147),
                                            )
                                          ],

                                        );
                                      },),

                                      decoration: valueChecked1 == true
                                      ? TextDecoration.lineThrough
                                      :TextDecoration.none,
                                      title: valueList[index].Tasktitle!,
                                      startTime: valueList[index].startTime!,
                                      endTime: valueList[index].endTime!,

                                  



                            ),
                          );
                      },);
                    }
                  },))
          ],
        ),
      ),
    );
  }


  Future taskDone(TaskModel task, int key, String category, bool valueChecked1,
      bool valueChecked2) async {
    task.iscompleted = valueChecked1;
    task.isImportant = valueChecked2;
    await TaskFunctions().editTask(task, key);
  }

  Future initializeTask()async{
    await CategoryFunction().filterTaskByCategory(widget.category);
    await CategoryFunction().filterTaskByCategoryOnThisDay(todayy);
  }
}