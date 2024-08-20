import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:first_project_app/model/memorymodel.dart';
import 'package:first_project_app/db_Functions/memory_db.dart';
import 'package:photo_view/photo_view.dart';

class MemoryCard extends StatelessWidget {
  final MemoryModel memory;
  final Function() onDelete;
  final Function() onUpdate;

  const MemoryCard({
    Key? key, 
    required this.memory, 
    required this.onDelete,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    memory.text,
                    style: GoogleFonts.irishGrover(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (memory.photoUrls.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: memory.photoUrls.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => PhotoView(imageProvider: FileImage(File(memory.photoUrls[index]))),)
                              );
                            },
                            child: Image.file(
                              File(memory.photoUrls[index]),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => _confirmDeletePhoto(context, memory.photoUrls[index]),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Memory',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.bold),),
          content: Text('Are you sure you want to delete this memory?',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.normal),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.normal),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete',style: GoogleFonts.irishGrover(color: Colors.red,fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePhoto(BuildContext context, String photoUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Photo',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.bold),),
          content: Text('Are you sure you want to delete this photo?',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.normal),),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: GoogleFonts.irishGrover(color: Colors.black,fontWeight: FontWeight.normal),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete',style: GoogleFonts.irishGrover(color: Colors.red,fontWeight: FontWeight.normal),),
              onPressed: () async {
                Navigator.of(context).pop();
                final memoryFunction = MemoryFunction();
                await memoryFunction.removePhotoFromMemory(memory.id, photoUrl);
                onUpdate();
              },
            ),
          ],
        );
      },
    );
  }
}