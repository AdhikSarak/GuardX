// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:guardx/consts/index.dart';

Widget newCustomButton(String buttonLabel, textColor, color, onPress, border) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 10,
      minimumSize: const Size.fromHeight(50),
      backgroundColor: border == true ? bgColor : color,
      disabledBackgroundColor: disabledButtonColor,
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: border == true
          ? BorderSide(color: buttonBorderColor, width: 0.5)
          : BorderSide(color: color, width: 0.1),
    ),
    onPressed: onPress,
    child:
        buttonLabel.text.color(textColor).fontFamily(bold).size(16).make(),
  );
}

class CustomStatefulButton extends StatefulWidget {
  Color color;
  String buttonLabel;
  Color textColor;
  bool border;
  VoidCallback? onPress;
  CustomStatefulButton({
    super.key,
    required this.color,
    required this.buttonLabel,
    required this.textColor,
    required this.border,
    required this.onPress,
  });

  @override
  State<CustomStatefulButton> createState() => _CustomStatefulButtonState();
}

class _CustomStatefulButtonState extends State<CustomStatefulButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        minimumSize: const Size.fromHeight(36),
        backgroundColor: widget.border == true ? bgColor : widget.color,
        disabledBackgroundColor: disabledButtonColor,
        padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: widget.border == true
            ? BorderSide(color: buttonBorderColor, width: 0.5)
            : BorderSide(color: widget.color, width: 0.0),
      ),
      onPressed: widget.onPress,
      child: widget.buttonLabel.text
          .color(widget.textColor)
          .fontFamily(semibold)
          .size(12)
          .make(),
    );
  }
}
