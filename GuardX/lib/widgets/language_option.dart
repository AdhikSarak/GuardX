import 'package:flutter/material.dart'; 
import 'package:guardx/consts/colors.dart';
import 'package:guardx/widgets/small_text.dart';

class LanguageOption extends StatelessWidget {
  final String language;
  final String languageLabel;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.language,
    required this.languageLabel,
    required this.isSelected,
    required this.onTap,
  });

  IconData getLanguageIcon() {
    switch (language) {
      case 'English':
        return Icons.language;
      case 'Hindi':
        return Icons.translate;
      case 'Marathi':
        return Icons.g_translate;
      case 'Gujarati':
        return Icons.public;
      default:
        return Icons.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.mainColor
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.whiteColor,
              child: Icon(
                getLanguageIcon(),
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                      text: language, size: 20, color: AppColor.whiteColor),
                  SmallText(text: languageLabel, color: AppColor.whiteColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
