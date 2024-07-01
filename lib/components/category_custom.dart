import 'package:flutter/material.dart';
import 'package:nanny_organizer/components/custom_button.dart';

class CategoryCustom extends StatelessWidget {
  final double? height;
  final int? id;
  final String text;
  bool? isSelect;
  Color? color;
  Color? textColor;
  TextStyle? textStyle;

  CategoryCustom({
    required this.text,
    this.textStyle,
    this.textColor,
    this.color,
    this.height,
    this.isSelect = false,
    this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: CustomButton(
        height: height,
        color: isSelect! ? Color.fromRGBO(88, 255, 227, 1) : color,
        border: Border.all(color: isSelect! ? Colors.transparent : Color.fromRGBO(188, 188, 227, 1), width: 1),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
