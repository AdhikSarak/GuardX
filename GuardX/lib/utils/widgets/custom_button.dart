import 'package:guardx/consts/index.dart';

Widget customButton(String buttonLabel, textColor, bgcolor, onPress) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 10,
      minimumSize: const Size.fromHeight(36),
      backgroundColor: bgcolor,
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: buttonBorderColor, width: 0.5
        )
      ),
    ),
    onPressed: onPress,
    child: buttonLabel.text.color(textColor).fontFamily(semibold).size(12).make(),
  );
}
