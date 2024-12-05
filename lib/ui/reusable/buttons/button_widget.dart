import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/ui/reusable/buttons/bounce_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'button_long_shape1.dart';
import 'button_long_shape2.dart';
import 'button_long_shape3.dart';
import 'button_shape1.dart';
import 'button_shape2.dart';
import 'button_shape3.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  /// text for long button types
  final String? text;

  /// icon for long or icon buttons
  final String? icon;
  final double width;
  final double height;
  final ButtonType btnType;
  final bool disabled;

  const ButtonWidget({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    required this.width,
    required this.height,
    required this.btnType,
    this.disabled = false
  });

  @override
  Widget build(BuildContext context) {
    // Determine which button shape to render based on ButtonType
    CustomPainter getPainter(ButtonType type) {
      switch (type) {
        case ButtonType.long1:
          return ButtonLongShape1();
        case ButtonType.long2:
          return ButtonLongShape2();
        case ButtonType.long3:
          return ButtonLongShape3();
        case ButtonType.icon1:
          return ButtonShape1();
        case ButtonType.icon2:
          return ButtonShape2(disabled: disabled);
        case ButtonType.icon3:
          return ButtonShape3();
        default:
          return ButtonLongShape1();
      }
    }

    return SizedBox(
      width: width.w,
      height: height.w,
      child: Bounce(
        onTap: onTap,
        child: CustomPaint(
          size: Size(width.w, height.w),
          painter: getPainter(btnType),
          child: (text != null)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null ? Image.asset(icon!, width: 25.w, height: 25.w, color: AppTheme.iconColor) : const SizedBox.shrink(),
                    icon != null ? 24.horizontalSpace : const SizedBox.shrink(),
                    Text(
                      text!,
                      style: TextStyle(
                          fontSize: 20.sp, fontFamily: AppTheme.primaryFont, fontWeight: FontWeight.w600, color: AppTheme.primaryTextColor),
                    ),
                  ],
                )
              : Center(child: Image.asset(icon!, width: 24.w, height: 24.w, color: btnType == ButtonType.icon3 ? AppTheme.secIconColor :  (disabled ? Colors.white.withOpacity(0.6) : AppTheme.iconColor),)),
        ),
      ),
    );
  }
}

enum ButtonType { long1, long2, long3, icon1, icon2, icon3 }
