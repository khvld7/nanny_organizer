import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/calendar_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  void Function(DateTime)? onDisabledDayTapped;
  bool Function(DateTime)? selectedDayPredicate;
  void Function(DateTime, DateTime)? onDaySelected;

  ScheduleCalendar({this.onDisabledDayTapped, this.selectedDayPredicate, this.onDaySelected, super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  PageController _pageController = PageController();

  void _onLeftChevronTap() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _onRightChevronTap() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    formatterDateNow = DateFormat.yMMMMd('ru_RU').format(date);
    dateText = formatterDateNow.toString();
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(114, 110, 255, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomButton(
                      width: 24,
                      height: 24,
                      onPressed: () => _onLeftChevronTap(),
                      child: SvgPicture.asset('assets/icons/calendar_back.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        DateFormat.MMM('ru_RU').format(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomButton(
                      width: 24,
                      height: 24,
                      onPressed: () => _onRightChevronTap(),
                      child: SvgPicture.asset('assets/icons/calendar_next.svg'),
                    ),
                  ],
                ),
                Text(
                  DateFormat.y('ru_RU').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(241, 246, 255, 1),
                  ),
                ),
              ],
            ),
          ),
          TableCalendar(
            onCalendarCreated: (pageController) => _pageController = pageController,
            headerVisible: false,
            calendarFormat: CalendarFormat.week,
            onDisabledDayTapped: widget.onDisabledDayTapped,
            selectedDayPredicate: widget.selectedDayPredicate,
            onDaySelected: widget.onDaySelected,
            locale: 'ru_RU',
            focusedDay: date,
            firstDay: date,
            lastDay: DateTime.utc(2030, 12, 31),
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                fontFamily: 'Roboto',
                color: Color.fromRGBO(188, 188, 227, 1),
              ),
              weekendStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Color.fromRGBO(255, 88, 88, 1),
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(88, 255, 227, 1),
              ),
              selectedTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Color.fromRGBO(12, 22, 84, 1),
              ),
              defaultTextStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              disabledDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              todayTextStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
              ),
              disabledTextStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
              weekendTextStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
