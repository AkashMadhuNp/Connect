import 'package:first_project_app/class/menu_items.dart';
import 'package:first_project_app/customWidgets/custompopupbtn.dart';
import 'package:first_project_app/db_Functions/category_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCategoryContainer extends StatefulWidget {
  final String category;
  final Widget? text;
  final String text2;
  final String text3;
  final IconData? icon;
  final VoidCallback onTap;
  
  
  CustomCategoryContainer({
    super.key, 
    required this.category,
    required this.text, 
    required this.text2, 
    required this.text3,
    required this.icon, 
    required this.onTap});

  @override
  State<CustomCategoryContainer> createState() => _CustomCategoryContainerState();
}

class _CustomCategoryContainerState extends State<CustomCategoryContainer> {
  bool _showFullText = false;
  bool _showFullText2 = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
         // color: const Color.fromARGB(255, 34, 22, 3),
          gradient: LinearGradient(
            colors: [
               Colors.blue.shade100,
           Colors.purple.shade100
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius:8,
                spreadRadius: 2,
                offset: Offset(0, 3) 
              )
            ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(left: 15),
                child: 
                
                 widget.icon != null
                ? Icon(widget.icon,
                color: Colors.black,
                size: 20,
                ):SizedBox(),
                ),
      
      
                CustomPopUpButton(items: [
                  MenuItems(
                    title: "Delete", 
                    icon: Icons.delete_outline_rounded, 
                    onTap: widget.onTap
                    )
                ], color: Colors.black)
              ],
            ),
      
            Padding(padding: EdgeInsets.only(
              left: 50,
            ),
            child: widget.text,
            ),


            FutureBuilder(
              future: Future.wait([
                CategoryFunction().taskDoneinCategory(widget.category),
                CategoryFunction().taskNotDoneinCategory(widget.category)
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var taskDoneData = snapshot.data?[0];
                  var taskNotDoneData = snapshot.data?[1];

                  if (taskDoneData == 0 && taskNotDoneData == 0) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'No task in this category',
                        style: GoogleFonts.irishGrover(color: Colors.red.shade400, fontSize: 11),
                      ),
                    ));
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showFullText2 = !_showFullText2;
                            });
                          },
                          child: FutureBuilder(
                              future: CategoryFunction()
                                  .taskDoneinCategory(widget.category),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return Container(
                                    width: 60,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color:
                                            Color.fromARGB(255, 214, 209, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 194, 192, 192),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${snap.data.toString()} done',
                                            style: GoogleFonts.irishGrover(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 62, 40, 163)),
                                            textAlign: TextAlign.center,
                                            overflow: _showFullText2
                                                ? null
                                                : TextOverflow.ellipsis),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    width: 30,
                                  );
                                }
                              }),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _showFullText = !_showFullText;
                              });
                            },
                            child: FutureBuilder(
                                future: CategoryFunction()
                                    .taskNotDoneinCategory(widget.category),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 239, 210, 210),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 194, 192, 192)
                                                  .withOpacity(0.7),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 3),
                                            )
                                          ]),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${snap.data.toString()} not done',
                                            style: GoogleFonts.irishGrover(
                                              color: Color.fromARGB(
                                                  255, 149, 39, 39),
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: _showFullText
                                                ? null
                                                : TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                })),
                      ],
                    );
                  }
                } else {
                  return const Text('');
                }
              })
      
      
            
          ],
        ),
      ),
    );
  }
}