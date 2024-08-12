
import 'dart:io';

import 'package:first_project_app/db_Functions/event_db.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/view_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({super.key});

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<EventModel> _filteredEvents=[];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(20.0),
       child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color:const Color.fromARGB(255, 197, 185, 197)
                          .withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2), 
            )
          ]
        ),
        child: TextFormField(
          controller: searchController,
          onChanged: _filteredEventss,
          decoration: InputDecoration(
            hintText: "Search here....",
            hintStyle: GoogleFonts.irishGrover(),
            prefixIcon: Icon(
              Icons.search_outlined,
              color: Colors.grey,
              ),
              fillColor: Color.fromARGB(255, 244, 232, 249),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none
                )
          ),
        ),
       ), 
        ),


        Expanded(
          child: _filteredEvents.isEmpty
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/searchtask.svg',height: 150,),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No such Event found",
                style: GoogleFonts.irishGrover(
                  fontSize: 18
                ),),
                )
            ],
          )
          :ListView.builder(
            itemCount: _filteredEvents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)

                    ),

                    gradient: const LinearGradient(
                      colors: [
                         Color.fromARGB(255, 252, 219, 205),
                                  Color.fromARGB(255, 232, 203, 249),

                    ])
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewEvent(index: _filteredEvents[index]),));
                      
                    },
                    leading: _filteredEvents[index].eventImage != null
                    ? SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.file(File(_filteredEvents[index].eventImage ?? '')),
                    ):null,
                    title: Text(
                      _filteredEvents[index].eventTitle!,
                      style: GoogleFonts.irishGrover(
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    subtitle: Text(_filteredEvents[index].eventDate ?? '',
                     style: GoogleFonts.irishGrover(),
                    ),
                    trailing: Text(
                      _filteredEvents[index].eventTime ?? '',
                       style: GoogleFonts.irishGrover(
                        letterSpacing: 2
                       ),
                       ),

                  ),
                ),
                );
            },)
          )
      ],
    );
  }

  _filteredEventss(title)async{
    List<EventModel> events = await EventFunctions().filterEventsBasedOnSearch(title);

    setState(() {
      _filteredEvents=events;
    });
  }
}