 
import 'package:guardx/consts/index.dart';

class SmallText extends StatelessWidget {
  Color color;
  final String text;
  double size;
  double height;
  TextAlign align;

  FontWeight weight;
  SmallText(
      {super.key,
      this.size = 12,
      this.height = 1.2,
      this.color = AppColor.smallTextcolor,
      this.align = TextAlign.start,
      required this.text,
      this.weight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: 4,
      style: TextStyle(
          color: color,
          fontFamily: 'Poppins',
          fontWeight: weight == FontWeight.normal ? FontWeight.w400 : weight,
          fontSize: size,
          height: height,
          decoration: TextDecoration.none),
    );
  }
}
