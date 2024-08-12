
import 'package:first_project_app/screens/calenderScreen/calender_screen.dart';
import 'package:first_project_app/screens/task/task_done.dart';
import 'package:first_project_app/screens/task/task_important.dart';
import 'package:first_project_app/screens/task/task_notdone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
 with SingleTickerProviderStateMixin {

 @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

   @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  

  late TabController controller;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      // appBar: AppBar(
      //    automaticallyImplyLeading: false, 
      //   toolbarHeight: 60,
      //   backgroundColor: Colors.orange,
      //   centerTitle: true,
      //   title: Text("Task Page",
      //   style: GoogleFonts.irishGrover(
      //     color: Colors.white,
      //     fontSize: 20,
      //     fontWeight: FontWeight.w500,
      //     letterSpacing: 3
      //   ),
      //   ),),




        body: SafeArea(
          child: Container(
            color: Colors.yellow.shade100,
            child: Padding(
              padding: EdgeInsets.only(right: 10,left: 10,top: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      
                      child: TabBar(
                        dividerHeight: 0,
                        indicatorColor: Colors.white,
                        indicatorPadding: EdgeInsets.all(11),
          
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white
                        ),
                        controller: controller,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Text("All",
                            style: GoogleFonts.irishGrover(
                              
                            ),),
                          ),
          
                           Tab(
                            child: Text("Done",
                            style: GoogleFonts.irishGrover(
                            
                            ),),
                          ),
          
                           Tab(
                            child: Text("Not Done",
                            style: GoogleFonts.irishGrover(
                              
                            ),),
                          ),
          
                           Tab(
                            child: Text("Important",
                            style: GoogleFonts.irishGrover(
                              fontSize: 13
                            ),),
                          ),
                        ],
                      ),
                    ),
          
                    Expanded(child: TabBarView(
                      controller: controller,
                      children:const[
          
                        CalenderScreen(),
                        TaskDone(),
                        TaskNotDone(),
                      Taskimportant(),
                        
          
          
          
                      ]
                      )
                      )
                  ],
                ),
              ),
              ),
            
          ),
        ),
    );
  }
}