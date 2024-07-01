import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/add_schedule_card.dart';
import 'package:nanny_organizer/components/calendar_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/schedule_calendar.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:intl/intl.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:table_calendar/table_calendar.dart';

class AddSchedule extends StatefulWidget {
  DateTime? time;
  AddSchedule({this.time, super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  Map<String, dynamic> cardLength = {
    'number': '',
    'time': '',
    'name': '',
    'discriptions': '',
  };
  List<Map<String, dynamic>> card = [
    {
      'number': '',
      'time': '',
      'name': '',
      'discriptions': '',
    }
  ];
  String? time;

  List<TextEditingController> controllers = [
    TextEditingController(),
  ];
  selectedDay(day, focusedDay) {
    setState(() {
      date = day;
      formatterDateNow = DateFormat.yMMMMd('ru_RU').format(date);
      dateText = formatterDateNow.toString();
    });
  }

  @override
  void initState() {
    card[0]['time'] = widget.time;
    controllers[0].text = formatMinute.format(widget.time ?? DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/launch.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(188, 188, 227, 1),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            leadingWidth: 40,
            leading: Container(
              padding: EdgeInsets.only(left: 16),
              child: CustomButton(
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset('assets/icons/back.svg'),
              ),
            ),
            title: Row(
              children: [
                Text(
                  'Создание расписания',
                  style: appBarSubtitle,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    isActive: card.first.entries.every((element) => element.value != ''),
                    border: card.first.entries.every((element) => element.value != '') == true
                        ? null
                        : Border.all(color: Color.fromRGBO(188, 188, 227, 1)),
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      card.forEach(
                        (element) {
                          if (element.entries.every((element) => element.value != '' && element.value != null))
                            scheduleBox.add(
                              ScheduleDB(
                                id: element['number'] - 1,
                                time: element['time'],
                                name: element['name'],
                                discriptions: element['discriptions'],
                                dateTime: date,
                              ),
                            );
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prata',
                        color: card.first.entries.every((element) => element.value != '') == true
                            ? Color.fromRGBO(12, 22, 84, 1)
                            : Color.fromRGBO(188, 188, 227, 1),
                      ),
                    ),
                    color: card.first.entries.every((element) => element.value != '') == true
                        ? Color.fromRGBO(88, 255, 227, 1)
                        : Color.fromRGBO(241, 246, 255, 1),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 80),
            children: [
              ScheduleCalendar(
                onDisabledDayTapped: (day) => selectedDay(day, date),
                selectedDayPredicate: (day) => isSameDay(day, date),
                onDaySelected: selectedDay,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: card.length,
                itemBuilder: (BuildContext context, int index) {
                  return AddScheduleCard(
                    number: index + 1,
                    controller: controllers[index],
                    onChangedName: (value) {
                      setState(() {
                        card[index]['number'] = index + 1;
                        card[index]['name'] = value;
                      });
                    },
                    onChangedDiscription: (value) {
                      setState(() {
                        card[index]['discriptions'] = value;
                      });
                    },
                    addCard: () {
                      setState(() {
                        controllers.add(TextEditingController());
                        card.add(cardLength);
                      });
                    },
                    openTimer: () {
                      showModalBottomSheet(
                        constraints: BoxConstraints(maxHeight: 220),
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              Container(
                                height: MediaQuery.sizeOf(context).height <= 750
                                    ? MediaQuery.sizeOf(context).height / 5
                                    : MediaQuery.sizeOf(context).height / 7,
                                child: CupertinoTheme(
                                  data: CupertinoThemeData(
                                    textTheme: CupertinoTextThemeData(
                                      dateTimePickerTextStyle: TextStyle(
                                        color: Color.fromRGBO(12, 22, 84, 1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.time,
                                    use24hFormat: true,
                                    onDateTimeChanged: (DateTime newDate) {
                                      card[index]['time'] = newDate;
                                      time = DateFormat('HH:mm').format(newDate);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 24, top: 20, right: 24),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Color.fromRGBO(88, 255, 227, 1),
                                        child: Text('Выбрать'),
                                        onPressed: () {
                                          controllers[index].text = time ?? DateFormat('HH:mm').format(DateTime.now());
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ).then((value) => setState(() {}));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
