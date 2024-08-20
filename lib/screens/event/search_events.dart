   

import 'dart:io';

import 'package:first_project_app/db_Functions/event_db.dart';
import 'package:first_project_app/model/eventmodel.dart';
import 'package:first_project_app/screens/event/view_event.dart';
import 'package:first_project_app/screens/event/edit_event.dart';
import 'package:first_project_app/customWidgets/calertbox.dart';
import 'package:first_project_app/customWidgets/custsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({super.key});

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<EventModel> _filteredEvents = [];
  TextEditingController searchController = TextEditingController();

  Future<void> _loadAllEvents() async {
    await EventFunctions().getallEvents();
    setState(() {
      _filteredEvents = eventNotifier.value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 197, 185, 197)
                      .withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ],
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
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: eventNotifier,
            builder: (context, allEvents, _) {
              if (allEvents.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple.shade300,
                  ),
                );
              } else if (_filteredEvents.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/searchtask.svg', height: 150),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "No such Event Found",
                        style: GoogleFonts.irishGrover(fontSize: 18),
                      ),
                    )
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: _filteredEvents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
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
                            bottomRight: Radius.circular(20),
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 252, 219, 205),
                              Color.fromARGB(255, 232, 203, 249),
                            ],
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ViewEvent(index: _filteredEvents[index]),
                            ));
                          },
                          leading: _filteredEvents[index].eventImage != null
                              ? SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.file(
                                    File(_filteredEvents[index].eventImage ??
                                        ''),
                                  ),
                                )
                              : null,
                          title: Text(
                            _filteredEvents[index].eventTitle!,
                            style: GoogleFonts.irishGrover(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            _filteredEvents[index].eventDate ?? '',
                            style: GoogleFonts.irishGrover(),
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (String value) {},
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'Delete',
                                child: ListTile(
                                  leading: const Icon(Icons.delete_rounded),
                                  title: const Text('Delete'),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomAlertBox(
                                          okText: 'Delete',
                                          text:
                                              'Are you sure you want to delete this event? ',
                                          title: 'Delete event?',
                                          onpressedCancel: () {
                                            Navigator.of(context).pop();
                                          },
                                          onpressedDelete: () async {
                                            await EventFunctions()
                                                .deleteEvent(
                                                    _filteredEvents[index].key)
                                                .then(
                                                  (value) =>
                                                      CustomSnackBar.show(
                                                    context,
                                                    'Event has been successfully deleted',
                                                  ),
                                                );
                                            Navigator.of(context).pop();
                                            _loadAllEvents();
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'Edit',
                                child: ListTile(
                                  leading: const Icon(Icons.edit_square),
                                  title: const Text('Edit'),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditEvents(
                                          index: _filteredEvents[index],
                                          keyy: _filteredEvents[index].key,
                                        ),
                                      ),
                                    ).then((_) => _loadAllEvents());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _filteredEventss(String query) async {
    setState(() {
      if (query.isEmpty) {
        _filteredEvents = eventNotifier.value;
      } else {
        _filteredEvents = eventNotifier.value
            .where((event) => event.eventTitle!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}