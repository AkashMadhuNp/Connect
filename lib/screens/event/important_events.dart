import 'dart:io';

import 'package:first_project_app/customWidgets/events/event_container.dart';
import 'package:first_project_app/customWidgets/tasks/emptyevent.dart';
import 'package:first_project_app/db_Functions/event_db.dart';
import 'package:first_project_app/screens/event/view_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImportantEvents extends StatefulWidget {
  const ImportantEvents({super.key});

  @override
  State<ImportantEvents> createState() => _ImportantEventsState();
}

class _ImportantEventsState extends State<ImportantEvents> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImportantEvents();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: importantEventNotifier,
      builder: (context, value, child) {
        if(value.isEmpty){
          return EmptyEvent(
            text: "No Imporatnt events has been marked",);
        }else{
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10
                ),

                child: EventContainer(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ViewEvent(index: value[index]),)
                      );

                      
                    },
                    leading: value[index].eventImage != null &&
                    value[index].eventImage!.isNotEmpty
                    ? SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.file(
                        File(value[index].eventImage!),
                        fit: BoxFit.cover,
                      ),

                      
                    ):null,

                    title: Text(
                      value[index].eventTitle!,
                      style: GoogleFonts.irishGrover(
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    subtitle: Text(value[index].eventDate!,style: GoogleFonts.irishGrover(),),
                    trailing: Text(value[index].eventTime!,style: GoogleFonts.irishGrover(
                      letterSpacing: 2
                    )),
                  )),
                );
            },);
        }
      },
    );
  }

  Future<void> loadImportantEvents()async{
    await EventFunctions().getImportantEvents();
  }
}