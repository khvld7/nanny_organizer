import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/globals.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(160, 175, 175, 0.25),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color.fromRGBO(88, 255, 227, 1),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: CustomButton(
                onPressed: () => launchURL(uri: 'https://flutter.dev/'),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/confidentialy.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Политика конфиденциальности',
                        style: TextStyle(
                          color: Color.fromRGBO(12, 22, 84, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(160, 175, 175, 0.25),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color.fromRGBO(88, 255, 227, 1),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: CustomButton(
                onPressed: () => launchURL(uri: 'https://dart.dev/'),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/article.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Пользовательское соглашение',
                        style: TextStyle(
                          color: Color.fromRGBO(12, 22, 84, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                height: 0.2,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(160, 175, 175, 0.25),
                  ),
                ],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color.fromRGBO(88, 255, 227, 1),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: CustomButton(
                onPressed: markApp,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/like.svg'),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Оценить приложение',
                        style: TextStyle(
                          color: Color.fromRGBO(12, 22, 84, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
