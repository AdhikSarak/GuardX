import 'package:flutter/material.dart';
import 'package:guardx/widgets/big_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? forgroundColor;
  final Color? textColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding; // Add padding parameter

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.forgroundColor,
    this.onPressed,
    this.borderRadius = 8.0,
    this.textColor,
    this.borderColor = const Color(0xFFFFFFFF),
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          foregroundColor: forgroundColor,
          disabledBackgroundColor: backgroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: BigText(
          text: text,
          weight: FontWeight.bold,
          color: textColor ?? Colors.white,
          size: 18,
        ));
  }
}
