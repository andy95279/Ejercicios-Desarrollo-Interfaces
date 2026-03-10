import 'package:flutter/material.dart';

class PatternPainter extends CustomPainter {
  final int pattern;
  final Color color;
  PatternPainter(this.pattern, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    if (pattern == 1) {
      // Diagonal lines
      for (double i = -size.width; i < size.width * 2; i += 15) {
        canvas.drawLine(
          Offset(i, 0),
          Offset(i + size.width, size.height),
          paint,
        );
      }
    } else if (pattern == 2) {
      // Dots
      for (double i = 5; i < size.width; i += 20) {
        for (double j = 5; j < size.height; j += 20) {
          canvas.drawCircle(Offset(i, j), 1.5, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
