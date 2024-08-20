
import 'package:first_project_app/customWidgets/floatingbutton.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/model/usermodel.dart';
import 'package:first_project_app/screens/event/event_page.dart';
import 'package:first_project_app/screens/home/home_page.dart';
import 'package:first_project_app/screens/perfomance/perfomance_page.dart';
import 'package:first_project_app/screens/task/taskpage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeNavPage extends StatefulWidget {
  const HomeNavPage({super.key});

  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  int myCurrentIndex = 0;
  
  final List<Widget> pages = const [
    HomeScreen(),
    TaskPage(),
    EventScreen(),
    PerfomancePage(),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.yellow.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: pages[myCurrentIndex],
      ),
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
            child: GNav(
              gap: 8,
              backgroundColor: Colors.orangeAccent,
              color: Colors.white,
              activeColor: Colors.orange,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              selectedIndex: myCurrentIndex, // Highlight the selected tab
              onTabChange: (index) {
                setState(() {
                  myCurrentIndex = index; // Update the selected index
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.task,
                  text: 'Task',
                ),
                GButton(
                  icon: Icons.event,
                  text: 'Events',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Performance',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) => CustomFloating(),);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }



  Future<String?> initializeCurrentkey()async{
    return await UserFunctions().getCurrentUserKey();
  } 



  Future<UserModel?>loadCurrentUser()async{
    return await UserFunctions().getCurrentUser(userKey!);
  }
}
