import 'package:first_project_app/screens/event/important_events.dart';
import 'package:first_project_app/screens/event/search_events.dart';
import 'package:first_project_app/screens/event/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _TaskTabBarState();
}

class _TaskTabBarState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
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
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   backgroundColor: Colors.orange,
      //   toolbarHeight: 60,
      //   title:Text("Event Page",style: GoogleFonts.irishGrover(
      //     color: Colors.white,
      //     fontWeight: FontWeight.w500,
      //     letterSpacing: 2
      //   ),),
      // ),
      body: SafeArea(
        child: Container(
          color: Colors.yellow.shade100,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                // const SizedBox(
                //   height: 40,
                //  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    dividerHeight: 0,
                    indicatorColor: Colors.red,
                    indicatorPadding: const EdgeInsets.all(13),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                         color: Colors.white),
                    controller: controller,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs:  [
                      Tab(
                        child: Text(
                          'All',
                          style: GoogleFonts.irishGrover(),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Favourites',
                          style: GoogleFonts.irishGrover(),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'search',
                          style: GoogleFonts.irishGrover(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: const [
                      
                      UpcomingEvents(),
                      ImportantEvents(),
                      SearchEvent()
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
