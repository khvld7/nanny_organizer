import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/calendar_custom.dart';

launchURL({required String uri}) async {
  final Uri url = Uri.parse(uri);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

markApp() async {
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...');
  }
}

openCalendar({
  required BuildContext context,
  required Function() setState,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
        contentPadding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Prata',
                    color: Color.fromRGBO(12, 22, 84, 1),
                  ),
                  height: 35,
                  child: Text('Закрыть'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
              ),
              Expanded(
                child: CustomButton(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Prata',
                    color: Color.fromRGBO(12, 22, 84, 1),
                  ),
                  height: 35,
                  textColor: Color.fromRGBO(12, 22, 84, 1),
                  color: Color.fromRGBO(88, 255, 227, 1),
                  borderRadius: BorderRadius.circular(16),
                  child: Text('Выбрать'),
                  onPressed: () {
                    setState();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
        content: CalendarCustom(),
      );
    },
  );
}
