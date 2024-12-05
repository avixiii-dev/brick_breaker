import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonLongShape3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.01805408, size.height * 0.2381182);
    path_0.cubicTo(size.width * 0.02123706, size.height * 0.1037956,
        size.width * 0.05625640, 0, size.width * 0.09839242, 0);
    path_0.lineTo(size.width * 0.9194313, 0);
    path_0.cubicTo(size.width * 0.9639289, 0, size.width,
        size.height * 0.1153206, size.width, size.height * 0.2575758);
    path_0.lineTo(size.width, size.height * 0.5748394);
    path_0.cubicTo(
        size.width,
        size.height * 0.7114121,
        size.width * 0.9666588,
        size.height * 0.8242439,
        size.width * 0.9240047,
        size.height * 0.8319985);
    path_0.lineTo(size.width * 0.09186398, size.height * 0.9832970);
    path_0.cubicTo(
        size.width * 0.04321962,
        size.height * 0.9921424,
        size.width * 0.003270128,
        size.height * 0.8620000,
        size.width * 0.006950711,
        size.height * 0.7066803);
    path_0.lineTo(size.width * 0.01805408, size.height * 0.2381182);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.7017536, size.height * 0.2878788),
        Offset(size.width * 0.6326872, size.height * 1.090935),
        [AppTheme.primaryBtnColor1, AppTheme.primaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.06446493, size.height * 0.1140179);
    path_1.cubicTo(
        size.width * 0.07318815,
        size.height * 0.08019576,
        size.width * 0.08618294,
        size.height * 0.06060606,
        size.width * 0.09989479,
        size.height * 0.06060606);
    path_1.lineTo(size.width * 0.9407488, size.height * 0.06060606);
    path_1.cubicTo(
        size.width * 0.9517062,
        size.height * 0.06060606,
        size.width * 0.9619573,
        size.height * 0.07790848,
        size.width * 0.9681422,
        size.height * 0.1068377);
    path_1.lineTo(size.width * 0.9714597, size.height * 0.1223779);
    path_1.cubicTo(
        size.width * 0.9809005,
        size.height * 0.1665545,
        size.width * 0.9873081,
        size.height * 0.2166227,
        size.width * 0.9902559,
        size.height * 0.2692848);
    path_1.lineTo(size.width * 0.9913839, size.height * 0.2893864);
    path_1.cubicTo(
        size.width * 0.9949289,
        size.height * 0.3526879,
        size.width * 0.9801801,
        size.height * 0.4114288,
        size.width * 0.9600806,
        size.height * 0.4140545);
    path_1.lineTo(size.width * 0.05854929, size.height * 0.5317803);
    path_1.cubicTo(
        size.width * 0.03572114,
        size.height * 0.5347606,
        size.width * 0.01880502,
        size.height * 0.4648045,
        size.width * 0.02545720,
        size.height * 0.3949273);
    path_1.lineTo(size.width * 0.03612626, size.height * 0.2828576);
    path_1.cubicTo(
        size.width * 0.04200000,
        size.height * 0.2211576,
        size.width * 0.05163081,
        size.height * 0.1637773,
        size.width * 0.06446493,
        size.height * 0.1140179);
    path_1.lineTo(size.width * 0.06446493, size.height * 0.1140179);
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
