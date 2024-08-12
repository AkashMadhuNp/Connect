import 'package:first_project_app/customWidgets/tasks/customtaskcontainer.dart';
import 'package:first_project_app/model/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class NewCustomTimeLine extends StatelessWidget {
  String title;
  List<Color> colors;
  String startTime;
  String endTime;
  Widget item1;
  Widget item2;
  Color lineColor;
  Color indicatorColor;
  Color textColor;
  TaskModel? taskModel;
  VoidCallback onTap;
  VoidCallback? onItem2;
  VoidCallback? onItem1;
  BoxBorder? border;
  Widget? widget;
  TextDecoration? decoration;
  TextDecoration subtitleDecoration;
  final Function(BuildContext) onPressed1;
  final Function(BuildContext) onPressed2;


     NewCustomTimeLine({
      super.key,
      required this.title,
      required this.colors,
      required this.endTime,
      required this.startTime,
      required this.item1,
      required this.item2,
      this.decoration,
      this.border,
      this.taskModel,
      this.widget,
      this.onItem2,
      this.onItem1,
      required this.onTap,
      required this.onPressed1,
      required this.onPressed2,
      required this.lineColor,
      required this.indicatorColor,
      required this.textColor,
      required this.subtitleDecoration
       });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(), 
        children: [
          SlidableAction(
            onPressed: onPressed1,
            foregroundColor: Colors.grey,
            icon: Icons.delete_rounded,
            borderRadius: BorderRadius.circular(30),
            ),

            SlidableAction(
              onPressed: onPressed2,
              borderRadius:  BorderRadius.circular(30),
              foregroundColor: Colors.grey,
              icon: Icons.mode_edit_sharp,

              )
        ]),

        child: TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.23,
          beforeLineStyle: LineStyle(color: lineColor,thickness: 3),
          indicatorStyle: IndicatorStyle(
            width: 20,
            indicatorXY: 0.9,
            color: indicatorColor
          ),
          endChild: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 17,
              bottom: 10

            ),
            
            child: CustomTaskContainer(
              subtitleDecoration: subtitleDecoration,
              border: border,
              decoration: decoration,
              text: title, 
              widget: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: item1,
                      onTap: onItem1,
                      ),
                      PopupMenuItem(
                        child: item2,
                        onTap: onItem2,
                        )
                  ];
                
              },
              icon: Padding(padding: EdgeInsets.only(bottom: 18,left: 10),
              child: Icon(Icons.more_vert,size: 18,),
              ),
              
              ),
              onTap: onTap, 
              colors: colors, 
              startTime: startTime, 
              endTime: endTime),
            ),

            startChild: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Text(
                    startTime,
                    style: GoogleFonts.irishGrover(
                      decoration: subtitleDecoration,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor
                    ),
                  ),

                  SizedBox(height: 40,),

                  Text(
                    endTime,
                    style: GoogleFonts.irishGrover(
                      decoration: subtitleDecoration,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor
                    ),
                    )
                ],),
            ),
        ),
    );
  }
}