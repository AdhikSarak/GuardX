import 'package:flutter/material.dart'; 
import 'package:guardx/consts/strings.dart';
import 'package:guardx/widgets/big_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onSkipPressed;
  final VoidCallback? onOkPressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.onSkipPressed,
    required this.onOkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onSkipPressed,
          child: const BigText(text: AppText.skip),
        ),
        TextButton(
          onPressed: onOkPressed,
          child: const BigText(text: AppText.ok),
        ),
      ],
    );
  }
}
