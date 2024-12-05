import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../config/theme.dart';

class WindowShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.001200886, size.height * 0.1441927);
    path_0.cubicTo(size.width * -0.0009475652, size.height * 0.06512961,
        size.width * 0.07022092, 0, size.width * 0.1587633, 0);
    path_0.lineTo(size.width * 0.8412364, 0);
    path_0.cubicTo(
        size.width * 0.9297799,
        0,
        size.width * 1.000948,
        size.height * 0.06512961,
        size.width * 0.9987989,
        size.height * 0.1441927);
    path_0.lineTo(size.width * 0.9792772, size.height * 0.8626383);
    path_0.cubicTo(
        size.width * 0.9772011,
        size.height * 0.9390340,
        size.width * 0.9072690,
        size.height,
        size.width * 0.8217147,
        size.height);
    path_0.lineTo(size.width * 0.1782861, size.height);
    path_0.cubicTo(
        size.width * 0.09273125,
        size.height,
        size.width * 0.02279986,
        size.height * 0.9390340,
        size.width * 0.02072389,
        size.height * 0.8626383);
    path_0.lineTo(size.width * 0.001200886, size.height * 0.1441927);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.radial(
        path_0.getBounds().center, // Center of the path
        path_0.getBounds().longestSide / 1.5, // Radius covering the path
        [AppTheme.bgColor2, AppTheme.bgColor1],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
