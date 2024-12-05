import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonShape2 extends CustomPainter {

  final bool disabled;

  ButtonShape2({this.disabled = false});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.008544804, size.height * 0.3118857);
    path_0.cubicTo(size.width * 0.003863982, size.height * 0.1410352,
        size.width * 0.1410880, 0, size.width * 0.3120018, 0);
    path_0.lineTo(size.width * 0.6751250, 0);
    path_0.cubicTo(
        size.width * 0.8385625,
        0,
        size.width * 0.9726625,
        size.height * 0.1293920,
        size.width * 0.9785036,
        size.height * 0.2927232);
    path_0.lineTo(size.width * 0.9899161, size.height * 0.6119036);
    path_0.cubicTo(
        size.width * 0.9956000,
        size.height * 0.7708839,
        size.width * 0.8775911,
        size.height * 0.9072875,
        size.width * 0.7194464,
        size.height * 0.9245339);
    path_0.lineTo(size.width * 0.3547446, size.height * 0.9643036);
    path_0.cubicTo(
        size.width * 0.1784196,
        size.height * 0.9835321,
        size.width * 0.02323661,
        size.height * 0.8481393,
        size.width * 0.01837911,
        size.height * 0.6708339);
    path_0.lineTo(size.width * 0.008544804, size.height * 0.3118857);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.7017536, size.height * 0.2878786),
        Offset(size.width * 0.2734321, size.height * 0.7751304),
        disabled ? [Colors.grey.withOpacity(0.7),Colors.grey.withOpacity(0.5)] : [AppTheme.primaryBtnColor1, AppTheme.primaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1123371, size.height * 0.1759854);
    path_1.cubicTo(
        size.width * 0.1363718,
        size.height * 0.1359762,
        size.width * 0.1697329,
        size.height * 0.1023789,
        size.width * 0.2095714,
        size.height * 0.07806268);
    path_1.lineTo(size.width * 0.2095714, size.height * 0.07806268);
    path_1.cubicTo(
        size.width * 0.2549464,
        size.height * 0.05036696,
        size.width * 0.3070768,
        size.height * 0.03571429,
        size.width * 0.3602375,
        size.height * 0.03571429);
    path_1.lineTo(size.width * 0.5043339, size.height * 0.03571429);
    path_1.lineTo(size.width * 0.6417304, size.height * 0.03571429);
    path_1.cubicTo(
        size.width * 0.6881036,
        size.height * 0.03571429,
        size.width * 0.7337518,
        size.height * 0.04722482,
        size.width * 0.7745786,
        size.height * 0.06921321);
    path_1.lineTo(size.width * 0.7745786, size.height * 0.06921321);
    path_1.cubicTo(
        size.width * 0.8297571,
        size.height * 0.09893000,
        size.width * 0.8733786,
        size.height * 0.1462891,
        size.width * 0.8984696,
        size.height * 0.2037179);
    path_1.lineTo(size.width * 0.9065804, size.height * 0.2222839);
    path_1.cubicTo(
        size.width * 0.9214857,
        size.height * 0.2564018,
        size.width * 0.9306679,
        size.height * 0.2927411,
        size.width * 0.9337554,
        size.height * 0.3298446);
    path_1.lineTo(size.width * 0.9370536, size.height * 0.3694929);
    path_1.cubicTo(
        size.width * 0.9421000,
        size.height * 0.4301357,
        size.width * 0.8942429,
        size.height * 0.4821429,
        size.width * 0.8333893,
        size.height * 0.4821429);
    path_1.lineTo(size.width * 0.1355173, size.height * 0.4821429);
    path_1.cubicTo(
        size.width * 0.09025982,
        size.height * 0.4821429,
        size.width * 0.05357143,
        size.height * 0.4454536,
        size.width * 0.05357143,
        size.height * 0.4001964);
    path_1.lineTo(size.width * 0.05357143, size.height * 0.3719857);
    path_1.cubicTo(
        size.width * 0.05357143,
        size.height * 0.3077464,
        size.width * 0.07104750,
        size.height * 0.2447179,
        size.width * 0.1041277,
        size.height * 0.1896518);
    path_1.lineTo(size.width * 0.1123371, size.height * 0.1759854);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = AppTheme.reflectionColor;
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
