import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final TextOverflow overflow;
  final double size;
  final FontWeight weight;
  const BigText({
    super.key,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.weight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        color: color,
        fontSize: size == 0 ? 26 : size,
        fontWeight: weight == FontWeight.normal ? FontWeight.w400 : weight,
      ),
    );
  }
}
