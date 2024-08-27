import 'dart:io';
import 'package:first_project_app/db_Functions/memory_db.dart';
import 'package:first_project_app/model/memorymodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoryPage extends StatefulWidget {
  final String eventId;
  const AddMemoryPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<AddMemoryPage> createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _photoUrls = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Text(
          "Add Memories",
          style: GoogleFonts.irishGrover(
            fontSize: 25,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              TextField(
                maxLines: 3,
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "Memory Description",
                  labelStyle: GoogleFonts.irishGrover(
                    color: Colors.black,
                    fontSize: 20
                  ),
                  hintText: "What made this event special?",
                  hintStyle: GoogleFonts.irishGrover(
                    color: Colors.grey
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _openImagePicker,
                icon: Icon(Icons.photo_library),
                label: Text("Add Photos", style: GoogleFonts.irishGrover(
                  fontSize: 18
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  color: Colors.yellow.shade200,
                  child: GridView.builder(
                    itemCount: _photoUrls.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(File(_photoUrls[index]), fit: BoxFit.cover),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _photoUrls.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.close, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveMemory,
                      child: Text("Save Memory", style: GoogleFonts.irishGrover(
                        fontSize: 18
                      )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMemory() async {
    if (_textController.text.trim().isEmpty && _photoUrls.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add a description or photo")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final memoryFunction = MemoryFunction();
      
      MemoryModel memory = MemoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        eventId: widget.eventId,
        text: _textController.text.trim(),
        photoUrls: _photoUrls,
        createdAt: DateTime.now(),
      );

      await memoryFunction.addMemory(memory);

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving memory: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openImagePicker() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiImagePickerPage(
          onImagesSelected: (List<String> selectedImages) {
            setState(() {
              _photoUrls.addAll(selectedImages);
            });
          },
        ),
      ),
    );
  }
}

class MultiImagePickerPage extends StatefulWidget {
  final Function(List<String>) onImagesSelected;

  MultiImagePickerPage({required this.onImagesSelected});

  @override
  _MultiImagePickerPageState createState() => _MultiImagePickerPageState();
}

class _MultiImagePickerPageState extends State<MultiImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        title: Text('Select Images',style: GoogleFonts.irishGrover(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              widget.onImagesSelected(_selectedImages.map((image) => image.path).toList());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: _selectedImages.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: _pickImage,
              child: Container(
                color: Colors.grey[300],
                child: Icon(Icons.add_a_photo, size: 50),
              ),
            );
          } else {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(_selectedImages[index - 1].path),
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImages.removeAt(index - 1);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

}