import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonShape1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.005201185, size.height * 0.1898435);
    path_0.cubicTo(size.width * 0.002351989, size.height * 0.08584761,
        size.width * 0.08587967, 0, size.width * 0.1899141, 0);
    path_0.lineTo(size.width * 0.7897424, 0);
    path_0.cubicTo(
        size.width * 0.8892261,
        0,
        size.width * 0.9708522,
        size.height * 0.07876033,
        size.width * 0.9744076,
        size.height * 0.1781793);
    path_0.lineTo(size.width * 0.9938620, size.height * 0.7222652);
    path_0.cubicTo(
        size.width * 0.9973217,
        size.height * 0.8190359,
        size.width * 0.9254902,
        size.height * 0.9020641,
        size.width * 0.8292283,
        size.height * 0.9125620);
    path_0.lineTo(size.width * 0.2266522, size.height * 0.9782717);
    path_0.cubicTo(
        size.width * 0.1193239,
        size.height * 0.9899761,
        size.width * 0.02486478,
        size.height * 0.9075630,
        size.width * 0.02190793,
        size.height * 0.7996380);
    path_0.lineTo(size.width * 0.005201185, size.height * 0.1898435);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.7017543, size.height * 0.2878793),
        Offset(size.width * 0.2734326, size.height * 0.7751304),
        [AppTheme.primaryBtnColor1, AppTheme.primaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.07859163, size.height * 0.09914663);
    path_1.cubicTo(
        size.width * 0.08956913,
        size.height * 0.07747141,
        size.width * 0.1089141,
        size.height * 0.06121304,
        size.width * 0.1321554,
        size.height * 0.05413011);
    path_1.lineTo(size.width * 0.1321554, size.height * 0.05413011);
    path_1.cubicTo(
        size.width * 0.1789761,
        size.height * 0.03986130,
        size.width * 0.2276522,
        size.height * 0.03260870,
        size.width * 0.2765978,
        size.height * 0.03260870);
    path_1.lineTo(size.width * 0.5107446, size.height * 0.03260870);
    path_1.lineTo(size.width * 0.7346620, size.height * 0.03260870);
    path_1.cubicTo(
        size.width * 0.7862446,
        size.height * 0.03260870,
        size.width * 0.8369163,
        size.height * 0.04620967,
        size.width * 0.8815652,
        size.height * 0.07204022);
    path_1.lineTo(size.width * 0.8815652, size.height * 0.07204022);
    path_1.cubicTo(
        size.width * 0.9154478,
        size.height * 0.09164152,
        size.width * 0.9378261,
        size.height * 0.1263511,
        size.width * 0.9416967,
        size.height * 0.1653022);
    path_1.lineTo(size.width * 0.9590837, size.height * 0.3403033);
    path_1.cubicTo(
        size.width * 0.9635326,
        size.height * 0.3850783,
        size.width * 0.9283652,
        size.height * 0.4239130,
        size.width * 0.8833696,
        size.height * 0.4239130);
    path_1.lineTo(size.width * 0.1195652, size.height * 0.4239130);
    path_1.cubicTo(
        size.width * 0.07754359,
        size.height * 0.4239130,
        size.width * 0.04347826,
        size.height * 0.3898478,
        size.width * 0.04347826,
        size.height * 0.3478261);
    path_1.lineTo(size.width * 0.04347826, size.height * 0.2411533);
    path_1.cubicTo(
        size.width * 0.04347826,
        size.height * 0.1933750,
        size.width * 0.05472685,
        size.height * 0.1462674,
        size.width * 0.07631380,
        size.height * 0.1036442);
    path_1.lineTo(size.width * 0.07859163, size.height * 0.09914663);
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
