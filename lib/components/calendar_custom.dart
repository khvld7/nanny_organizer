import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CalendarCustom extends StatefulWidget {
  const CalendarCustom({super.key});

  @override
  State<CalendarCustom> createState() => _CalendarCustomState();
}

String? dateText;
var formatterDateNow;
var formatteDateMonth;
var formatter = DateFormat('dd.MM.yyyy');
var formatMinute = DateFormat('HH:mm');
late DateTime date;

class _CalendarCustomState extends State<CalendarCustom> {
  @override
  void initState() {
    date = DateTime.now();
    super.initState();
  }

  selectedDay(day, focusedDay) {
    setState(() {
      date = day;
      formatterDateNow = DateFormat.yMMMMd('ru_RU').format(date);
      dateText = formatterDateNow.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2.5,
      width: MediaQuery.sizeOf(context).width,
      child: TableCalendar(
        daysOfWeekHeight: 24,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Color.fromRGBO(188, 188, 227, 1),
            fontSize: 8,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
          weekendStyle: TextStyle(
            color: Color.fromRGBO(188, 188, 227, 1),
            fontSize: 8,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
        ),
        calendarStyle: CalendarStyle(
          tableBorder: TableBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          outsideTextStyle: TextStyle(
            color: Color.fromRGBO(188, 188, 227, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
          weekendTextStyle: TextStyle(
            color: Color.fromRGBO(12, 22, 84, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          todayTextStyle: TextStyle(
            color: Color.fromRGBO(12, 22, 84, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
          selectedDecoration: BoxDecoration(
            color: Color.fromRGBO(88, 255, 227, 1),
            shape: BoxShape.circle,
          ),
          disabledTextStyle: TextStyle(
            color: Color.fromRGBO(12, 22, 84, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
          defaultTextStyle: TextStyle(
            color: Color.fromRGBO(12, 22, 84, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
          selectedTextStyle: TextStyle(
            color: Color.fromRGBO(12, 22, 84, 1),
            fontSize: 10,
            fontWeight: FontWeight.w300,
            fontFamily: 'Roboto',
          ),
        ),
        rowHeight: 30,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          headerPadding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color.fromRGBO(241, 246, 255, 1))),
          ),
          titleTextFormatter: (date, locale) {
            return DateFormat.yMMM(locale).format(date);
          },
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Source_Sans',
            fontWeight: FontWeight.w400,
          ),
          leftChevronMargin: EdgeInsets.zero,
          leftChevronIcon: SvgPicture.asset('assets/icons/calendar_back.svg'),
          rightChevronPadding: EdgeInsets.zero,
          rightChevronIcon: SvgPicture.asset('assets/icons/calendar_next.svg'),
          formatButtonVisible: false,
          titleCentered: true,
        ),
        sixWeekMonthsEnforced: true,
        onDisabledDayTapped: (day) => selectedDay(day, date),
        selectedDayPredicate: (day) => isSameDay(day, date),
        onDaySelected: selectedDay,
        locale: 'ru_RU',
        focusedDay: date,
        firstDay: date,
        lastDay: DateTime.utc(2030, 12, 31),
      ),
    );
  }
}
