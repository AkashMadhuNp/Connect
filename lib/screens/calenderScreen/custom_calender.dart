// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CategoryTablecalender extends StatefulWidget {
  final void Function(DateTime, DateTime) onDayselected;
  final Function(DateTime?, DateTime?, DateTime)? onRangeSelected;
  final bool Function(DateTime)? fun;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  const CategoryTablecalender(
      {super.key,
      required this.onDayselected,
      required this.fun,
      this.onRangeSelected,
      this.rangeStart,
      this.rangeEnd});

  @override
  State<CategoryTablecalender> createState() => _CategoryTablecalenderState();
}

class _CategoryTablecalenderState extends State<CategoryTablecalender> {
  //DateTime _selectedDay = DateTime.now();
DateTime _focusedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.week;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          selectedDayPredicate: widget.fun,
          rangeStartDay: widget.rangeStart,
          rangeEndDay: widget.rangeEnd,
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          onDaySelected: widget.onDayselected,
          onRangeSelected: widget.onRangeSelected,
          calendarFormat: _format,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          headerStyle: HeaderStyle(
            titleTextStyle: GoogleFonts.irishGrover(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ).
                  createShader(
                    const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)
                    )),
            
            formatButtonVisible: true,
            formatButtonDecoration: BoxDecoration(
              border: Border.all(
                color: Colors.purple, 
                width: 2
                ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            formatButtonTextStyle:  GoogleFonts.irishGrover(
              color: Color.fromARGB(255, 212, 131, 131),
            ),
          ),
          onFormatChanged: (format_) => setState(() {
            _format = format_;
          }),
          
          
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle:
                  GoogleFonts.irishGrover(
                    color: Colors.purple, 
                    fontWeight: FontWeight.bold,
                    
                    ),
              weekendStyle:
                  GoogleFonts.irishGrover(
                    color: Colors.purple, 
                    fontWeight: FontWeight.bold
                    )),
        ));
  }
}
