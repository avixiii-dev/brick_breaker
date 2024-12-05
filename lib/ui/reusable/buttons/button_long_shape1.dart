import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonLongShape1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.007695753, size.height * 0.2808955);
    path_0.cubicTo(size.width * 0.003563146, size.height * 0.1300548,
        size.width * 0.03935626, 0, size.width * 0.08500274, 0);
    path_0.lineTo(size.width * 0.8990776, 0);
    path_0.cubicTo(
        size.width * 0.9384110,
        0,
        size.width * 0.9715251,
        size.height * 0.09762121,
        size.width * 0.9761598,
        size.height * 0.2272288);
    path_0.lineTo(size.width * 0.9900411, size.height * 0.6153697);
    path_0.cubicTo(
        size.width * 0.9953973,
        size.height * 0.7652258,
        size.width * 0.9609589,
        size.height * 0.8981970,
        size.width * 0.9155023,
        size.height * 0.9031530);
    path_0.lineTo(size.width * 0.1006205, size.height * 0.9920152);
    path_0.cubicTo(
        size.width * 0.05951370,
        size.height * 0.9964985,
        size.width * 0.02448799,
        size.height * 0.8938121,
        size.width * 0.02076434,
        size.height * 0.7578985);
    path_0.lineTo(size.width * 0.007695753, size.height * 0.2808955);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.7017534, size.height * 0.2878788),
        Offset(size.width * 0.6373151, size.height * 1.095003),
        [AppTheme.primaryBtnColor1, AppTheme.primaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.07973653, size.height * 0.07094742);
    path_1.cubicTo(
        size.width * 0.08501187,
        size.height * 0.06411318,
        size.width * 0.09062557,
        size.height * 0.06060606,
        size.width * 0.09628904,
        size.height * 0.06060606);
    path_1.lineTo(size.width * 0.9206575, size.height * 0.06060606);
    path_1.cubicTo(
        size.width * 0.9264932,
        size.height * 0.06060606,
        size.width * 0.9320594,
        size.height * 0.06880470,
        size.width * 0.9359726,
        size.height * 0.08317273);
    path_1.lineTo(size.width * 0.9359726, size.height * 0.08317273);
    path_1.cubicTo(
        size.width * 0.9545982,
        size.height * 0.1515409,
        size.width * 0.9649132,
        size.height * 0.2404227,
        size.width * 0.9649132,
        size.height * 0.3325864);
    path_1.lineTo(size.width * 0.9649132, size.height * 0.3389333);
    path_1.cubicTo(
        size.width * 0.9649132,
        size.height * 0.3779015,
        size.width * 0.9555160,
        size.height * 0.4097030,
        size.width * 0.9437717,
        size.height * 0.4104682);
    path_1.lineTo(size.width * 0.05771096, size.height * 0.4682227);
    path_1.cubicTo(
        size.width * 0.04528904,
        size.height * 0.4690318,
        size.width * 0.03508767,
        size.height * 0.4358409,
        size.width * 0.03508767,
        size.height * 0.3946136);
    path_1.lineTo(size.width * 0.03508767, size.height * 0.2878318);
    path_1.cubicTo(
        size.width * 0.03508767,
        size.height * 0.1919227,
        size.width * 0.05281187,
        size.height * 0.1058271,
        size.width * 0.07973653,
        size.height * 0.07094742);
    path_1.lineTo(size.width * 0.07973653, size.height * 0.07094742);
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
