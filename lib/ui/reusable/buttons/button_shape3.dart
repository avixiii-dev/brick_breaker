import 'dart:ui' as ui;
import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';

class ButtonShape3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9932700, size.height * 0.2424792);
    path_0.cubicTo(size.width * 0.9969571, size.height * 0.1096329,
        size.width * 0.8871929, 0, size.width * 0.7505014, 0);
    path_0.lineTo(size.width * 0.2664186, 0);
    path_0.cubicTo(
        size.width * 0.1356193,
        0,
        size.width * 0.02831557,
        size.height * 0.1007140,
        size.width * 0.02371243,
        size.height * 0.2278014);
    path_0.lineTo(size.width * 0.007927929, size.height * 0.6635958);
    path_0.cubicTo(
        size.width * 0.003456414,
        size.height * 0.7870500,
        size.width * 0.09761929,
        size.height * 0.8929875,
        size.width * 0.2239071,
        size.height * 0.9065819);
    path_0.lineTo(size.width * 0.7102271, size.height * 0.9589347);
    path_0.cubicTo(
        size.width * 0.8514600,
        size.height * 0.9741389,
        size.width * 0.9758900,
        size.height * 0.8687250,
        size.width * 0.9797229,
        size.height * 0.7306264);
    path_0.lineTo(size.width * 0.9932700, size.height * 0.2424792);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.2982457, size.height * 0.2841875),
        Offset(size.width * 0.7339600, size.height * 0.7587778),
        [AppTheme.secondaryBtnColor1, AppTheme.secondaryBtnColor2],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9290343, size.height * 0.1137322);
    path_1.cubicTo(
        size.width * 0.9189229,
        size.height * 0.08120264,
        size.width * 0.8893914,
        size.height * 0.05798486,
        size.width * 0.8545571,
        size.height * 0.05517958);
    path_1.lineTo(size.width * 0.7566029, size.height * 0.04729139);
    path_1.cubicTo(
        size.width * 0.5953329,
        size.height * 0.03430444,
        size.width * 0.4332357,
        size.height * 0.03427194,
        size.width * 0.2719614,
        size.height * 0.04719417);
    path_1.lineTo(size.width * 0.1708729, size.height * 0.05529389);
    path_1.cubicTo(
        size.width * 0.1357821,
        size.height * 0.05810556,
        size.width * 0.1048021,
        size.height * 0.07866250,
        size.width * 0.08932100,
        size.height * 0.1094081);
    path_1.lineTo(size.width * 0.08932100, size.height * 0.1094081);
    path_1.cubicTo(
        size.width * 0.06325114,
        size.height * 0.1611833,
        size.width * 0.04522414,
        size.height * 0.2164306,
        size.width * 0.03582814,
        size.height * 0.2733486);
    path_1.lineTo(size.width * 0.03287843, size.height * 0.2912167);
    path_1.cubicTo(
        size.width * 0.02312471,
        size.height * 0.3503014,
        size.width * 0.07006414,
        size.height * 0.4038444,
        size.width * 0.1316149,
        size.height * 0.4038444);
    path_1.lineTo(size.width * 0.8917786, size.height * 0.4038444);
    path_1.cubicTo(
        size.width * 0.9321686,
        size.height * 0.4038444,
        size.width * 0.9649114,
        size.height * 0.3720125,
        size.width * 0.9649114,
        size.height * 0.3327444);
    path_1.lineTo(size.width * 0.9649114, size.height * 0.3327444);
    path_1.cubicTo(
        size.width * 0.9649114,
        size.height * 0.2640653,
        size.width * 0.9545286,
        size.height * 0.1957597,
        size.width * 0.9340957,
        size.height * 0.1300174);
    path_1.lineTo(size.width * 0.9290343, size.height * 0.1137322);
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
