import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 50)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
