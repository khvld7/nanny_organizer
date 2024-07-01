import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/style.dart';
import 'package:nanny_organizer/globals.dart';
import 'package:nanny_organizer/onboarding/onboarding.dart';
import 'package:nanny_organizer/screens/screens.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  void nextScreen() {
    if (active_screen_id < 2) {
      active_screen_id += 1;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Screens();
          },
        ),
        (Route<dynamic> route) => false,
      ).then(
        (value) => setState(() {}),
      );
    }
  }

  int active_screen_id = 0;
  List<Onboarding> screenData = [
    Onboarding(
      screenId: 0,
      image: 'assets/images/onboarding_screen_0.png',
      title: 'Расписание',
      text: 'Создавайте и отслеживайте расписания детей на каждый день.',
      textTwo: 'Добавляйте события, не пропускайте важные дела и контролируйте процент их выполнения',
    ),
    Onboarding(
      screenId: 1,
      image: 'assets/images/onboarding_screen_1.png',
      title: 'Дневник Прогресса',
      text: 'Ведите записи о поведении, эмоциональном состоянии и достижениях каждого ребенка.',
      textTwo: 'Добавляйте комментарии и заметки о наблюдениях и прогрессе.',
    ),
    Onboarding(
      screenId: 2,
      image: 'assets/images/onboarding_screen_2.png',
      title: 'Тревожные Ситуации',
      text: 'Добавляйте собственные инструкций или используйте имеющиеся',
      textTwo: 'Записывайте необходимые контакты экстренных случаев.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(114, 110, 255, 1),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    screenData[active_screen_id].image ?? '',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(188, 188, 227, 1),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.normal,
                      blurRadius: 5,
                      color: Color.fromRGBO(160, 175, 175, 0.25),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        screenData[active_screen_id].title ?? '',
                        style: onboardingTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, top: 7, left: 10),
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                          ),
                          Expanded(
                            child: Text(
                              screenData[active_screen_id].text ?? '',
                              style: onboardingText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10, top: 7, left: 10),
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                          ),
                          Expanded(
                            child: Text(
                              screenData[active_screen_id].textTwo ?? '',
                              style: onboardingText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          setState(() {
                            if (active_screen_id == 0 || active_screen_id == 1) {
                              active_screen_id = 2;
                            } else {
                              nextScreen();
                            }
                          });
                        },
                        height: 40,
                        child: Text(
                          'Пропустить',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Prata',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          setState(() {
                            nextScreen();
                          });
                        },
                        height: 40,
                        color: Color.fromRGBO(88, 255, 227, 1),
                        borderRadius: BorderRadius.circular(16),
                        child: Text(
                          'Продолжить',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Prata'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => launchURL(uri: 'https://flutter.dev'),
                    child: Text(
                      'Условия использования ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(188, 188, 227, 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(88, 255, 227, 1),
                    ),
                    width: 1,
                    height: 15,
                  ),
                  RawMaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => launchURL(uri: 'https://dart.dev'),
                    child: Text(
                      'Политика конфиденциальности',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(188, 188, 227, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
