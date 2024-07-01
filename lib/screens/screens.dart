import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:nanny_organizer/database/database.dart';
import 'package:nanny_organizer/screens/diary.dart';
import 'package:nanny_organizer/screens/home.dart';
import 'package:nanny_organizer/screens/schedule.dart';
import 'package:nanny_organizer/screens/settings.dart';
import 'package:nanny_organizer/screens/situations.dart';
import 'package:nanny_organizer/screens/views/add_schedule.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _selectIndex = 0;
  List<Widget> screens = [
    HomeWidget(),
    ScheduleWidget(),
    DiaryWidget(),
    SituationsWidget(),
    SettingsWidget(),
  ];

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
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  if (_selectIndex == 0) Expanded(child: Text('Главная', style: appBarText, maxLines: 2, softWrap: true)),
                  if (_selectIndex == 1) Expanded(child: Text('Расписание', style: appBarText, maxLines: 2, softWrap: true)),
                  if (_selectIndex == 2) Expanded(child: Text('Дневник прогресса', style: appBarText, maxLines: 2, softWrap: true)),
                  if (_selectIndex == 3) Expanded(child: Text('Тревожные ситуации', style: appBarText, maxLines: 2, softWrap: true)),
                  if (_selectIndex == 4) Expanded(child: Text('Настройки', style: appBarText, maxLines: 2, softWrap: true)),
                ],
              ),
            ),
            actions: [
              if (_selectIndex == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset('assets/icons/schedule_icon.svg'),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AddSchedule();
                          },
                        ),
                      );
                      setState(() {
                        scheduleBox.values.forEach((element) {
                          if (element.dateTime?.day == DateTime.now().day) {
                            filtred.add(element);
                          }
                        });
                      });
                    },
                  ),
                ),
            ],
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(188, 188, 227, 1),
                  ),
                  left: BorderSide(
                    color: Color.fromRGBO(188, 188, 227, 1),
                  ),
                  right: BorderSide(
                    color: Color.fromRGBO(188, 188, 227, 1),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BottomNavigationBar(
                  useLegacyColorScheme: true,
                  currentIndex: _selectIndex,
                  onTap: (index) => setState(() {
                    _selectIndex = index;
                  }),
                  selectedLabelStyle: TextStyle(
                    color: Color.fromRGBO(12, 22, 84, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                  selectedFontSize: 12,
                  selectedItemColor: Color.fromRGBO(12, 22, 84, 1),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset('assets/icons/navbar/home.svg'),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navbar/home.svg',
                        colorFilter: ColorFilter.mode(Color.fromRGBO(7, 198, 172, 1), BlendMode.srcIn),
                      ),
                      label: 'Главная',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset('assets/icons/navbar/schedule.svg'),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navbar/schedule.svg',
                        colorFilter: ColorFilter.mode(Color.fromRGBO(7, 198, 172, 1), BlendMode.srcIn),
                      ),
                      label: 'Расписание',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset('assets/icons/navbar/diary.svg'),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navbar/diary.svg',
                        colorFilter: ColorFilter.mode(Color.fromRGBO(7, 198, 172, 1), BlendMode.srcIn),
                      ),
                      label: 'Дневник',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset('assets/icons/navbar/situations.svg'),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navbar/situations.svg',
                        colorFilter: ColorFilter.mode(Color.fromRGBO(7, 198, 172, 1), BlendMode.srcIn),
                      ),
                      label: 'Ситуации',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset('assets/icons/navbar/settings.svg'),
                      activeIcon: SvgPicture.asset(
                        'assets/icons/navbar/settings.svg',
                        colorFilter: ColorFilter.mode(Color.fromRGBO(7, 198, 172, 1), BlendMode.srcIn),
                      ),
                      label: 'Настройки',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Center(
            child: screens[_selectIndex],
          ),
        ),
      ],
    );
  }
}
