
import 'package:first_project_app/class/menu_items.dart';
import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/perfomance/perfomance_file.dart';
import 'package:first_project_app/customWidgets/usercontainer.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/task_db.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/homescreen.dart';
import 'package:first_project_app/screens/perfomance/cust_progress_indicator.dart';
import 'package:first_project_app/screens/perfomance/view_profile.dart';
import 'package:first_project_app/screens/task/task_done.dart';
import 'package:first_project_app/screens/task/task_notdone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerformPage extends StatefulWidget {
  const PerformPage({super.key});

  @override
  State<PerformPage> createState() => _PerformPageState();
}

class _PerformPageState extends State<PerformPage> {
  ValueNotifier<int?> perfomanceNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    int userPerfomance = PerfomanceOnThisDay();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adjusted padding to 16.0 for better spacing
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: userListNotifier,
                builder: (BuildContext context, List<UserModel> userList, Widget? _) {
                  return Usercontainer(
                    text: userList[keys.indexOf(userKey!)].name != null
                        ? userList[keys.indexOf(userKey!)].name!
                        : '',
                    img: userList[keys.indexOf(userKey!)].userImage ?? '',
                    color: Colors.white,
                    items: [
                      MenuItems(
                        title: "Profile",
                        icon: Icons.person_2_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewProfile(),));
                        },
                      ),
                      MenuItems(
                        title: "Privacy Policy",
                        icon: Icons.privacy_tip,
                        onTap: () {},
                      ),
                      MenuItems(
                        title: "App Info",
                        icon: Icons.info_outline_rounded,
                        onTap: () {},
                      ),
                      MenuItems(
                        title: "Logout",
                        icon: Icons.logout_outlined,
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlertBox(
                                text: "Are you sure you want to logout?",
                                title: "Logout",
                                onpressedCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onpressedDelete: () async {
                                  await UserFunctions()
                                      .checkUserLoggedIn(false, userKey!)
                                      .then((value) => Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()),
                                              (Route<dynamic> route) => false));
                                },
                                okText: "LogOut",
                              );
                            },
                          );
                        },
                      ),
                    ],

                  );
                },
              ),


              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ValueListenableBuilder(
                    valueListenable: taskDoneNotifier, 
                    builder: (context, List<TaskModel> taskDoneList, child) {
                      return PerfomanceCircle(
                        text1: taskDoneList.length.toString(), 
                        icon: Icons.circle_outlined, 
                        color: Colors.orange, 
                        text2: "Completed"
                        );
                      
                    }, 
                    ),

                    ValueListenableBuilder(
                      valueListenable: taskNotDoneNotifier, 
                      builder: (context, List<TaskModel> taskNotDone, child) {
                        return PerfomanceCircle(
                          text1: taskNotDone.length.toString(), 
                          icon: Icons.circle_outlined, 
                          color: Colors.grey, 
                          text2: "Not Completed"
                          );
                        
                      },)
                ],
              ),



              SizedBox(height: 40,),
              Center(
                child: ValueListenableBuilder(
                  valueListenable: perfomanceNotifier, 
                  builder: (context, perfomance, child_){
                    return GradientCircularPercentIndicator(
                      radius: height*0.12, 
                      percent: perfomance! /100);
                  } ,
                  ),
              ),


              SizedBox(height: 10,),

              if(userPerfomance >= 80)
              Text("Congratulations! \nYour Perfomance is outstanding.\n Keep up the great work!",
              style: GoogleFonts.irishGrover(),
              textAlign: TextAlign.center,
              )
              else if(userPerfomance >= 50 && userPerfomance < 80)
              Text(
                "Good job!\nYou're making progress with your tasks.\nKeep it up!",
              style: GoogleFonts.irishGrover(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87

              ),
              textAlign: TextAlign.center
              )
              else if(userPerfomance >= 20 && userPerfomance < 50)
              Text("You've completed fewer tasks.\nLets's try to tackle more tasks today!",
              style: GoogleFonts.irishGrover(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                 color: Colors.black87
              ),
              textAlign: TextAlign.center
              )
              else if(userPerfomance==0)
              Text("You haven't started yet, Let's get started!",
              style: GoogleFonts.irishGrover(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                 color: Colors.black87
              ),
              textAlign: TextAlign.center
              )
              else
              Text("It looks like there's room for improvement.\nStay Focused",
              style: GoogleFonts.irishGrover(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87
              ),
              textAlign: TextAlign.center
              )



            ],
          ),
        ),
      ),
    );
  }


  PerfomanceOnThisDay(){
    List<TaskModel> currentUserallTasks = currentUserTaskNotifier.value;
    final completeTask = currentUserallTasks.where((element)=>element.iscompleted!).length;
    final totalTask = currentUserallTasks.length;
    int perfomanceOfUser;
    if(totalTask != 0){
      perfomanceOfUser =((completeTask/totalTask)*100).toInt();
      perfomanceNotifier.value = perfomanceOfUser;
    }else{
      perfomanceNotifier.value =0;
      perfomanceOfUser = 0;
    }
    return perfomanceOfUser;
  }


  initialize()async{
    await TaskFunctions().getCurrentUserTask(userKey!);
    await TaskFunctions().getTaskDone();
    return await TaskFunctions().getTaskDone();
  }
}
