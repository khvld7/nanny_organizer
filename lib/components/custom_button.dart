import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final Function()? onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? color;
  final Color? textColor;
  final Border? border;
  BorderRadiusGeometry? borderRadius;
  bool isActive;
  final TextStyle? textStyle;

  CustomButton({
    super.key,
    required this.child,
    this.isActive = true,
    this.onPressed,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.textColor,
    this.borderRadius,
    this.textStyle,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: isActive ? color : color,
        border: border,
        borderRadius: borderRadius,
      ),
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      child: RawMaterialButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: isActive ? onPressed : () {},
        child: child,
        textStyle: textStyle,
      ),
    );
  }
}
