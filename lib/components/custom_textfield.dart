import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? labelText;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  TextCapitalization textCapitalization;
  bool readOnly;
  int? maxLines;
  List<TextInputFormatter>? inputFormatters;
  TextInputAction? textInputAction;
  String? initialValue;
  double paddingVerical;
  double paddingHorizontal;
  List<BoxShadow>? boxShadow;

  CustomTextfield({
    this.readOnly = false,
    this.boxShadow,
    this.paddingVerical = 16,
    this.paddingHorizontal = 12,
    this.labelText,
    this.suffixIcon,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixIcon,
    super.key,
    this.inputFormatters,
    this.hintText,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          padding: EdgeInsets.only(top: paddingVerical),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(188, 188, 227, 1),
            ),
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextFormField(
            onChanged: onChanged,
            readOnly: readOnly,
            initialValue: initialValue,
            onFieldSubmitted: onSubmitted,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            inputFormatters: inputFormatters,
            cursorColor: Color.fromRGBO(103, 116, 130, 1),
            textAlignVertical: TextAlignVertical.center,
            minLines: null,
            maxLines: maxLines,
            autocorrect: false,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Color.fromRGBO(114, 110, 255, 1),
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color.fromRGBO(188, 188, 227, 1),
                fontSize: 13,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w200,
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              fontFamily: 'Roboto',
              color: Color.fromRGBO(12, 22, 84, 1),
            ),
          ),
        ),
      ],
    );
  }
}
