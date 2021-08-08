//Draw a line
import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';

class Drawhorizontalline extends CustomPainter {
  late Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = ConstantColors.purpleDark
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-120.0, 0.0), Offset(120.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
