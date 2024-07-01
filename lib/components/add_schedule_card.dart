import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanny_organizer/components/custom_button.dart';
import 'package:nanny_organizer/components/custom_textfield.dart';

class AddScheduleCard extends StatelessWidget {
  int number;
  final Function()? addCard;
  final Function()? openTimer;
  TextEditingController? controller;
  final Function(String)? onChangedTime;
  final Function(String)? onChangedName;
  final Function(String)? onChangedDiscription;

  AddScheduleCard({
    super.key,
    this.addCard,
    this.openTimer,
    this.onChangedTime,
    this.onChangedName,
    this.onChangedDiscription,
    this.controller,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(
            color: Color.fromRGBO(114, 110, 255, 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/change_schedule.svg'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '#$number',
                      style: TextStyle(
                        color: Color.fromRGBO(114, 110, 255, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Prata',
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  width: 24,
                  height: 24,
                  onPressed: addCard,
                  child: SvgPicture.asset('assets/icons/add_schedule.svg'),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    width: 0.2,
                    color: Color.fromRGBO(114, 110, 255, 1),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Укажите время',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(114, 110, 255, 1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10, right: 24),
                    child: CustomTextfield(
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller,
                      hintText: 'Время',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomButton(
                          width: 24,
                          height: 24,
                          onPressed: openTimer,
                          child: SvgPicture.asset('assets/icons/clock.svg'),
                        ),
                      ),
                      readOnly: true,
                      paddingVerical: 0,
                      paddingHorizontal: 0,
                      onChanged: onChangedTime,
                    ),
                  ),
                  Text(
                    'Название',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(114, 110, 255, 1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10, right: 24),
                    child: CustomTextfield(
                      textCapitalization: TextCapitalization.sentences,
                      hintText: 'Название',
                      paddingVerical: 0,
                      paddingHorizontal: 0,
                      onChanged: onChangedName,
                    ),
                  ),
                  Text(
                    'Описание',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(114, 110, 255, 1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10, right: 24),
                    child: CustomTextfield(
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      hintText: 'Описание',
                      onChanged: onChangedDiscription,
                      paddingVerical: 0,
                      paddingHorizontal: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
