import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/memory/addmemorypage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoryPrompt extends StatelessWidget {
  final EventModel event;

  const MemoryPrompt({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Memories?', style: GoogleFonts.irishGrover()),
      content: Text('Would you like to add memories for the event "${event.eventTitle}"?', style: GoogleFonts.irishGrover()),
      actions: [
        TextButton(
          child: Text('No', style: GoogleFonts.irishGrover()),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Yes', style: GoogleFonts.irishGrover()),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddMemoryPage(eventId: event.key.toString()),
              ),
            );
          },
        ),
      ],
    );
  }
}