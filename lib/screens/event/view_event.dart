import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:first_project_app/customWidgets/events/eventview_row.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/custeventview_column.dart';

class ViewEvent extends StatelessWidget {
  final EventModel index;
  
  const ViewEvent({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title:  Text("Events",style: GoogleFonts.irishGrover(
          color: Colors.white,
          fontSize: 25,
          letterSpacing: 2

        ),),
        centerTitle: true,
        backgroundColor: Colors.orange,
        toolbarHeight: 100,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                   Color.fromARGB(255, 248, 242, 188),
                   Color.fromARGB(255, 235, 228, 168)
                    ], // Example gradient
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventViewRow(title: "Title", body: index.eventTitle ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Date", body: index.eventDate ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Time", body: index.eventTime ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Location", body: index.eventlocation ?? ''),


                    Divider(thickness: 2,),
                    if (index.eventDescription != null && index.eventDescription!.isNotEmpty)
                      EventViewcolumn(title: "Description", body: index.eventDescription!),

                      Divider(thickness: 2,),
                    const SizedBox(height: 10),
                    if (index.eventImage != null && index.eventImage!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageProvider: FileImage(File(index.eventImage!)),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Image.file(
                              File(index.eventImage!),
                              fit: BoxFit.cover,
                              height: 300, // Adjust as needed
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}