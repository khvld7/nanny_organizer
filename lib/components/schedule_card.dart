import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/components/calendar_custom.dart';
import 'package:nanny_organizer/components/custom_button.dart';

class ScheduleCard extends StatelessWidget {
  bool isSelect;
  final DateTime? time;
  final String? name;
  final String? discriptions;
  Function()? onPressed;

  ScheduleCard({super.key, this.onPressed, this.time, this.name, this.discriptions, this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatMinute.format(time ?? DateTime.now()),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: isSelect ? Color.fromRGBO(188, 188, 227, 1) : Color.fromRGBO(12, 22, 84, 1),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(114, 110, 255, 1),
                ),
                height: 8,
                width: 8,
              ),
              Expanded(
                child: Container(
                  width: 1,
                  color: Color.fromRGBO(114, 110, 255, 1),
                ),
              ),
            ],
          ),
          Flexible(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onPressed,
              child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isSelect == false ? Color.fromRGBO(114, 110, 255, 1) : Color.fromRGBO(188, 188, 227, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              discriptions ?? '',
                              maxLines: null,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      margin: EdgeInsets.only(left: 12),
                      width: 24,
                      height: 24,
                      child: isSelect == false
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color.fromRGBO(188, 188, 227, 1),
                                ),
                              ),
                            )
                          : SvgPicture.asset('assets/icons/radiobutton.svg'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
