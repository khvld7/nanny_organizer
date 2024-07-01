import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nanny_organizer/components/schedule_calendar.dart';
import 'package:nanny_organizer/components/schedule_card.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../adapter/hive_adapter.dart';
import '../components/calendar_custom.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => SscheduleState();
}

List<ScheduleDB> filtred = [];

class SscheduleState extends State<ScheduleWidget> {
  filtredDB(DateTime dateDB) {
    filtred.clear();
    scheduleBox.values.forEach((element) {
      if (element.dateTime?.day == dateDB.day) {
        filtred.add(element);
      }
    });
    setState(() {});
  }

  selectedDay(day, focusedDay) {
    setState(() {
      date = day;
      formatterDateNow = DateFormat.yMMMMd('ru_RU').format(date);
      dateText = formatterDateNow.toString();
    });
    filtredDB(date);
  }

  @override
  void initState() {
    date = DateTime.now();
    filtredDB(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          Column(
            children: [
              ScheduleCalendar(
                onDisabledDayTapped: (day) => selectedDay(day, date),
                selectedDayPredicate: (day) => isSameDay(day, date),
                onDaySelected: selectedDay,
              ),
              filtred.isNotEmpty
                  ? Container(
                      child: ValueListenableBuilder(
                        valueListenable: scheduleBox.listenable(),
                        builder: (BuildContext context, value, Widget? child) {
                          List<ScheduleDB> sorted = filtred.toList()..sort((a, b) => a.time!.compareTo(b.time!));
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 20, bottom: 80),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sorted.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ScheduleCard(
                                time: sorted[index].time,
                                name: sorted[index].name,
                                discriptions: sorted[index].discriptions,
                                onPressed: () => setState(() {
                                  sorted[index].isSelect = !sorted[index].isSelect;
                                }),
                                isSelect: sorted[index].isSelect,
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height / 5),
                      child: Text(
                        'На указанный день расписание не составлено.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(138, 138, 177, 1),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
