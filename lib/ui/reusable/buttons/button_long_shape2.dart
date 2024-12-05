import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonLongShape2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2537313);
    path_0.cubicTo(0, size.height * 0.1135994, size.width * 0.03556617, 0,
        size.width * 0.07943925, 0);
    path_0.lineTo(size.width * 0.9090841, 0);
    path_0.cubicTo(
        size.width * 0.9571916,
        0,
        size.width * 0.9942570,
        size.height * 0.1354940,
        size.width * 0.9878084,
        size.height * 0.2877612);
    path_0.lineTo(size.width * 0.9676028, size.height * 0.7645955);
    path_0.cubicTo(
        size.width * 0.9621215,
        size.height * 0.8939373,
        size.width * 0.9268131,
        size.height * 0.9889000,
        size.width * 0.8859766,
        size.height * 0.9841269);
    path_0.lineTo(size.width * 0.07653505, size.height * 0.8895403);
    path_0.cubicTo(size.width * 0.03382056, size.height * 0.8845493, 0,
        size.height * 0.7725000, 0, size.height * 0.6359791);
    path_0.lineTo(0, size.height * 0.2537313);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.6656822, size.height * 0.2835821),
        Offset(size.width * 0.5952944, size.height * 1.070207),
        [AppTheme.primaryBtnColor1, AppTheme.primaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.04274173, size.height * 0.1187578);
    path_1.cubicTo(
        size.width * 0.05898925,
        size.height * 0.08040090,
        size.width * 0.07865981,
        size.height * 0.05970149,
        size.width * 0.09886355,
        size.height * 0.05970149);
    path_1.lineTo(size.width * 0.9042056, size.height * 0.05970149);
    path_1.cubicTo(
        size.width * 0.9377570,
        size.height * 0.05970149,
        size.width * 0.9649533,
        size.height * 0.1465716,
        size.width * 0.9649533,
        size.height * 0.2537313);
    path_1.lineTo(size.width * 0.9649533, size.height * 0.3849343);
    path_1.cubicTo(
        size.width * 0.9649533,
        size.height * 0.4438418,
        size.width * 0.9497150,
        size.height * 0.4911015,
        size.width * 0.9312804,
        size.height * 0.4893657);
    path_1.lineTo(size.width * 0.02886444, size.height * 0.4043836);
    path_1.cubicTo(
        size.width * 0.02059551,
        size.height * 0.4036045,
        size.width * 0.01401869,
        size.height * 0.3819687,
        size.width * 0.01401869,
        size.height * 0.3555463);
    path_1.lineTo(size.width * 0.01401869, size.height * 0.3006493);
    path_1.cubicTo(
        size.width * 0.01401869,
        size.height * 0.2289000,
        size.width * 0.02467692,
        size.height * 0.1614045,
        size.width * 0.04274173,
        size.height * 0.1187578);
    path_1.lineTo(size.width * 0.04274173, size.height * 0.1187578);
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
