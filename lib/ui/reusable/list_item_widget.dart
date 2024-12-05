import 'package:brick_breaker/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItemWidget extends StatelessWidget {
  final Widget child;

  const ListItemWidget(
      {super.key,
      required this.child,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
      padding: EdgeInsets.all(8.w),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppTheme.fgColor1.withOpacity(0.6),AppTheme.fgColor2.withOpacity(0.6)],
          radius: 2
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4),offset: const Offset(0,1),blurRadius: 4,spreadRadius: 3)]
      ),
      child: child
    );
  }
}
