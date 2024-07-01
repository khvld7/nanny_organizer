import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nanny_organizer/adapter/hive_adapter.dart';
import 'package:nanny_organizer/components/calendar_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/schedule_card.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/screens/schedule.dart';
import 'package:nanny_organizer/screens/views/add_schedule.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  filtredDB(DateTime dateDB) {
    filtred.clear();
    scheduleBox.values.forEach((element) {
      if (element.dateTime?.day == dateDB.day) {
        filtred.add(element);
      }
    });
    setState(() {});
  }

  String? _now;
  Timer? _everySecond;
  double? percent;

  @override
  void initState() {
    date = DateTime.now();

    filtredDB(date);

    super.initState();
    _now = DateTime.now().hour.toString().padLeft(2, '0') + ':' + DateTime.now().minute.toString().padLeft(2, '0');
    _everySecond = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        if (mounted)
          setState(() {
            _now = DateTime.now().hour.toString().padLeft(2, '0') + ':' + DateTime.now().minute.toString().padLeft(2, '0');
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    percent = (filtred.where((element) => element.isSelect).length / filtred.length * 100);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        Column(
          mainAxisAlignment: scheduleBox.values.any((element) => element.dateTime?.day == date.day) == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            diaryBox.isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(7, 198, 172, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Последняя запись',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(241, 246, 255, 1),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            diaryBox.values.last.note ?? '',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Color.fromRGBO(114, 110, 255, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.shrink(),
                      Text(
                        _now ?? '',
                        style: TextStyle(
                          fontFamily: 'Praata',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      CustomButton(
                        width: 24,
                        height: 24,
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return AddSchedule(
                                  time: DateTime.now(),
                                );
                              },
                            ),
                          ).then((value) => setState(() {}));
                          filtredDB(DateTime.now());
                        },
                        child: SvgPicture.asset('assets/icons/add_circle.svg'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.shrink(),
                      Text(
                        '${DateFormat.yMMMEd('ru_RU').format(DateTime.now())}',
                        style: TextStyle(
                          color: Color.fromRGBO(188, 188, 227, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(width: 24),
                    ],
                  ),
                  scheduleBox.values.any((element) => element.dateTime?.day == date.day) == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Процент выполнения',
                                      style: TextStyle(
                                        color: Color.fromRGBO(188, 188, 227, 1),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${percent?.toInt()}%',
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 5,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  Container(
                                    height: 5,
                                    width: (MediaQuery.sizeOf(context).width - 70) * percent! * 0.01,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(88, 255, 227, 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
            scheduleBox.values.any((element) => element.dateTime?.day == date.day) == false
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/home_isEmpty.png'),
                        Text(
                          'На сегодня расписание не составлено.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Roboto',
                            color: Color.fromRGBO(138, 138, 177, 1),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return AddSchedule();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Составить сейчас.',
                            style: TextStyle(
                              decorationColor: Color.fromRGBO(114, 110, 255, 1),
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.5,
                              color: Color.fromRGBO(114, 110, 255, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ValueListenableBuilder(
                    valueListenable: scheduleBox.listenable(),
                    builder: (BuildContext context, value, Widget? child) {
                      List<ScheduleDB> sorted = filtred.toList()..sort((a, b) => a.time!.compareTo(b.time!));
                      return Container(
                        child: ListView.builder(
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
                        ),
                      );
                    },
                  ),
            SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
