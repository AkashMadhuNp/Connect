// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/custsnackbar.dart';
import 'package:first_project_app/db_Functions/event_db.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/calenderScreen/custom_calender.dart';
import 'package:first_project_app/screens/event/edit_event.dart';
import 'package:first_project_app/screens/event/memory/memoryprompt.dart';
import 'package:first_project_app/screens/event/view_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({super.key});

  @override
  State<UpcomingEvents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpcomingEvents> {
  bool? valueChecked1;
  ValueNotifier checknotifier = ValueNotifier(false);
  List<EventModel> events = [];
  @override
  void initState() {
    super.initState();
   initializeEvents();
   
  }

  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    //initializeEvents(); 

    return Column(
      children: [
        CategoryTablecalender(
          rangeStart: rangeStart,
          rangeEnd: rangeEnd,
          onRangeSelected: (start, end, focusedDay) async {
            setState(() {
              today = focusedDay;
              rangeStart = start;
              rangeEnd = end;
            });
            await EventFunctions() 

            
                .getCurrentUserEventsOnSelectedDay(start, end);
          },
          onDayselected: (DateTime day, DateTime focusedDay) async {
            setState(() {
              today = day;
            });
            await EventFunctions().getCurrentUserEventsOnSelectedDay(day, day);
          },
          fun: (dayy) => isSameDay(today, dayy),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: filteredEventsNotifier,
            builder: (context, value, child) {
              events = value;
              if (value.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: SvgPicture.asset(
                        'assets/donetask.svg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                     Text(
                      'no Events had been planned..\nClick Add to plan your days',
                      style: GoogleFonts.irishGrover(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                   
                    initializeEvents();
                    valueChecked1 = value[index].isImportant;
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              )
                            ],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 232, 203, 249),
                                Color.fromARGB(255, 252, 219, 205),
                              ],
                            )),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewEvent(
                                      index: value[index],
                                    )));
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
                                )
                              : null,
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (String value) {
                              // if (value == 'Option 1') {
                              //   Navigator.of(context).pop();
                              // } else if (value == 'Option 2') {
                              //   Navigator.of(context).pop();
                              // }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Option 1',
                                child: ListTile(
                                  leading: const Icon(Icons.delete_rounded),
                                  title: const Text('Delete'),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertBox(okText: 'Delete',
                                            text:
                                                'Are you sure you want to delete this event? ',
                                            title: 'Delete event?',
                                            onpressedCancel: () {
                                              Navigator.of(context).pop();
                                            },
                                            onpressedDelete: () async {
                                              await EventFunctions()
                                                  .deleteEvent(value[index].key)
                                                  .then((value) =>
                                                      CustomSnackBar.show(
                                                          context,
                                                          'Event has been successfully deleted'));
                                              Navigator.of(context).pop();
                                            });
                                      },
                                    );
                                  },
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Option 2',
                                child: ListTile(
                                  leading: const Icon(Icons.edit_square),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditEvents(
                                                  index: value[index],
                                                  keyy: value[index].key,
                                                )));
                                    //Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                          title: ValueListenableBuilder(
                            valueListenable: checknotifier,
                            builder: (context, valuecheck, child) {
                              return Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        checknotifier.value =
                                            !checknotifier.value!;
                                        valueChecked1 = !valueChecked1!;
                                        await eventDone(
                                            events[index], events[index].key);
                                      },
                                      icon: Icon(
                                        value[index].isImportant!
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: const Color.fromARGB(
                                            255, 66, 29, 160),
                                      )),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      value[index].eventTitle!,
                                      style: GoogleFonts.irishGrover(
                                        fontWeight: FontWeight.bold
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 47.0),
                            child: Text(value[index].eventDate!,
                            style: GoogleFonts.irishGrover(
                                      ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }

  initializeEvents() async {
    return await EventFunctions()
        .getCurrentUserEventsOnSelectedDay(rangeStart, rangeEnd);
  }

  Future eventDone(EventModel events, int key) async {
    events.isImportant = valueChecked1;
    return await EventFunctions().editEvents(events, key);
  }


  void checkEndedEvents()async{
    List<EventModel> endedEvents = await EventFunctions().getEndedEventsWithoutMemories();
    for(var event in endedEvents){
      WidgetsBinding.instance.addPostFrameCallback((_){
        showDialog(
          context: context, 
          builder: (BuildContext context) => MemoryPrompt(event: event) ,);
      });
    }
  }
}
