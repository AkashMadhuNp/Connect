import 'dart:io';

import 'package:first_project_app/customWidgets/customtextfield.dart';
import 'package:first_project_app/customWidgets/custsnackbar.dart';
import 'package:first_project_app/db_Functions/db_functions.dart';
import 'package:first_project_app/db_Functions/event_db.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/eventButton/event_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditEvents extends StatefulWidget {
  final EventModel index;
  final int keyy;
  const EditEvents({
    super.key, 
    required this.index, 
    required this.keyy});

  @override
  State<EditEvents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditEvents> {
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventdescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? date;

  File? imagepath;
  String? image;
  @override
  void initState() {
    super.initState();

    eventTitleController.text = widget.index.eventTitle ?? '';
    eventdescriptionController.text = widget.index.eventDescription ?? '';
    eventLocationController.text = widget.index.eventlocation ?? '';
    selectedDate = DateFormat('dd-MMM-yyy').parse(widget.index.eventDate ?? '');
    imagepath = File(widget.index.eventImage ?? '');
    selectedTime = TimeOfDay.fromDateTime(
        DateFormat('hh:mm a').parse(widget.index.eventTime!));
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title:  Text(
          'Edit Events',
          style: GoogleFonts.irishGrover(
            fontSize: 25,
            color: Colors.white,
            letterSpacing: 2
          ),
          
          ),
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          toolbarHeight: 100,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          ),
          color: Colors.yellow.shade100
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:  EdgeInsets.only(
                      left: width < 600 ? width * 0.04 : width * 0.3,
                      right: width < 600 ? width * 0.04 : width * 0.3),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: Stack(children: [
                          widget.index.eventImage == null ||
                                  widget.index.eventImage == ''
                              ? SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      'lib/assets/gallery/gallery.jpg'),
                                )
                              : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.file(
                                    imagepath!,
                                    fit: BoxFit.cover,
                                  )),
                          Positioned(
                              top: 60,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ))
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    datePicker();
                                  },
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.grey,
                                  )),
                              Text(
                                  DateFormat('dd-MMM-yyy').format(selectedDate!),
                                  style: GoogleFonts.irishGrover(),
                                  ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    timePicker();
                                  },
                                  icon: Icon(
                                    Icons.timer,
                                    color: Colors.grey,
                                  )),
                              Text(
                                selectedTime!.format(context),
                                style: GoogleFonts.irishGrover(
                                  letterSpacing: 2
                                ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          mode: AutovalidateMode.always,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'title can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'title',
                          customController: eventTitleController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          hintText: 'description',
                          customController: eventdescriptionController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          mode: AutovalidateMode.always,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'location can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'location',
                          customController: eventLocationController),
                      const SizedBox(
                        height: 20,
                      ),
                          SizedBox(width: width < 600 ? width * 0.96 : width * 0.5,
                            child: EventButton(
                                width: 340,
                                text: 'Edit',
                                onPressed: () async {
                                  await editButtonOnClicked(widget.keyy);
                                  Navigator.of(context).pop();
                                }),
          
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void datePicker() async {
    DateTime? now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  timePicker() async {
    //DateTime? pickedDateTime = selectedDate;
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      if (selectedDate != null &&
          time != null &&
          selectedDate!.hour <= time.hour &&
          selectedDate!.minute <= time.minute) {
        selectedTime = time;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Time'),
              content: const Text('Choose a upcomeing time'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      timePicker();
                    },
                    child: const Text('Ok'))
              ],
            );
          },
        );
      }
    });
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    setState(
      () {
        imagepath = File(returnedImage.path);
        image = returnedImage.path;
      },
    );
  }

  editButtonOnClicked(int key) async {
    String? currentUserKey = await UserFunctions().getCurrentUserKey();
    if (formKey.currentState!.validate()) {
      EventModel events = EventModel(
          eventTitle: eventTitleController.text.trim(),
          eventDescription: eventdescriptionController.text.trim(),
          eventDate: DateFormat('dd-MMM-yyy').format(selectedDate!),
          eventTime: selectedTime!.format(context),
          eventImage: imagepath?.path,
          userKey: currentUserKey!,
          isImportant: false,
          eventlocation: eventLocationController.text.trim());
      await EventFunctions().editEvents(events, key).then((value) =>
          CustomSnackBar.show(context, 'Event has been successfully edited'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to edit event. Please try again later.'),
      ));
    }
  }
}
