import 'dart:io';

import 'package:first_project_app/db_Functions/memory_db.dart';
import 'package:first_project_app/model/memorymodel.dart';
import 'package:first_project_app/screens/event/memory/addmemorypage.dart';
import 'package:first_project_app/screens/event/memory/memory_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:first_project_app/customWidgets/events/eventview_row.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/custeventview_column.dart';

class ViewEvent extends StatefulWidget {
  final EventModel index;
  
  
  const ViewEvent({Key? key, required this.index}) : super(key: key);

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  List<MemoryModel> memories=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMemories();

  }

  Future<void> _loadMemories()async{
    final memoryFunction = MemoryFunction();
    final loadMemories = await memoryFunction.getMemoriesForEvent(widget.index.key.toString());
    setState(() {
      memories = loadMemories;
    });

  }
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
                    EventViewRow(title: "Title", body: widget.index.eventTitle ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Date", body: widget.index.eventDate ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Time", body: widget.index.eventTime ?? ''),
                    const Divider(thickness: 1),
                    EventViewRow(title: "Location", body: widget.index.eventlocation ?? ''),


                    Divider(thickness: 2,),
                    if (widget.index.eventDescription != null && widget.index.eventDescription!.isNotEmpty)
                      EventViewcolumn(title: "Description", body: widget.index.eventDescription!),

                      Divider(thickness: 2,),
                    const SizedBox(height: 10),
                    if (widget.index.eventImage != null && widget.index.eventImage!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageProvider: FileImage(File(widget.index.eventImage!)),
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: Image.file(
                              File(widget.index.eventImage!),
                              fit: BoxFit.cover,
                              height: 150, 
                              width: 150,// Adjust as needed
                            ),
                          ),
                        ),
                      ),



                      const Divider(thickness: 2,),
                      Text("Memories",style: GoogleFonts.irishGrover(
                        color: Colors.purple,
                        fontSize: 25
                      ),),

                      if (memories.isEmpty)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'No memories added yet!',
                  style: GoogleFonts.irishGrover(
                    color: Colors.grey,
                    fontSize: 14
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  return MemoryCard(
                  memory: memories[index], 
                  onDelete: ()=>_deleteMemory(memories[index].id), 
                  onUpdate: _loadMemories);
                },
              ),


              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.orange)
                  ),
                  onPressed: () async{
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMemoryPage(eventId: widget.index.key.toString()),)
                  );
                  _loadMemories();
                }, 
                child: Text("Add Memory",style: GoogleFonts.irishGrover(
                  color: Colors.white,
                  fontSize: 18,
                  
                ),)
                ),
              )



                      
                  ],
                ),
              ),
            ),






          ),
        ),
      ),
    );
  }

  Future<void> _deleteMemory(String memoryId)async{
    final memoryFunction = MemoryFunction();
    await memoryFunction.deleteMemory(memoryId);
    _loadMemories();
  }
}


