import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class WindowTitleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.006251818, size.height * 0.4606128);
    path_0.cubicTo(size.width * -0.01486551, size.height * 0.2379532,
        size.width * 0.02648930, 0, size.width * 0.08630374, 0);
    path_0.lineTo(size.width * 0.9136952, 0);
    path_0.cubicTo(
        size.width * 0.9735080,
        0,
        size.width * 1.014866,
        size.height * 0.2379532,
        size.width * 0.9937487,
        size.height * 0.4606128);
    path_0.lineTo(size.width * 0.9660909, size.height * 0.7522319);
    path_0.cubicTo(
        size.width * 0.9519519,
        size.height * 0.9013234,
        size.width * 0.9160856,
        size.height,
        size.width * 0.8760321,
        size.height);
    path_0.lineTo(size.width * 0.1239674, size.height);
    path_0.cubicTo(
        size.width * 0.08391604,
        size.height,
        size.width * 0.04804947,
        size.height * 0.9013234,
        size.width * 0.03390930,
        size.height * 0.7522319);
    path_0.lineTo(size.width * 0.006251818, size.height * 0.4606128);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.radial(
        path_0.getBounds().center, // Center of the path
        path_0.getBounds().longestSide / 1, // Radius covering the path
        [AppTheme.fgColor1.withOpacity(0.5), AppTheme.fgColor2.withOpacity(0.5)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
