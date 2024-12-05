import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../reusable/window_title_shape.dart';

class HelpAlert extends StatelessWidget {
  const HelpAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 16.w,
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      gradient: const RadialGradient(
                          colors: [AppTheme.bgColor2, AppTheme.bgColor1], radius: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 45.w,
                            ),
                            ButtonWidget(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                width: 45,
                                height: 45,
                                icon: 'assets/icons/cross.png',
                                btnType: ButtonType.icon3),
                          ],
                        ),
                        24.verticalSpace,
                        ListView.builder(
                          itemCount: helpList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  helpList[index]['title'] ?? '',
                                  style: TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                4.verticalSpace,
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  child: Text(
                                    helpList[index]['description'] ?? '',
                                    style: TextStyle(
                                        color: AppTheme.primaryTextColor,
                                        fontFamily: AppTheme.primaryFont,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                8.verticalSpace,
                              ],
                            ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              CustomPaint(
                size: Size(
                    400,
                    (200 * 0.25133689839572193).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: WindowTitleShape(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 36.w),
                  child: Text(
                    'How to Play',
                    style: TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontFamily: AppTheme.primaryFont,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const helpList = [
  {
    'title': 'Aiming and Shooting',
    'description': '• Drag to aim and release to shoot the balls towards the bricks\n• Each hit on a brick reduces its hit count. When the hit count reaches zero, the brick breaks.'
  },
  {
    'title': 'Collecting Balls',
    'description': '• Increase your ball count by hitting special balls that appear during the game. Collecting more balls allows you to shoot multiple balls at once, increasing your chances of breaking more bricks.'
  },
  {
    'title': 'Black Holes',
    'description': '• Watch out for black holes! Hitting a black hole will reduce your ball count.\n• Black holes can be broken by hitting them multiple times, but each hit reduces your balls, so be strategic.'
  },
  {
    'title': 'Collecting Stars',
    'description': '• Collect stars as you play. These stars can be used to buy powerful upgrades from the shop.\n• Use power-ups to gain an advantage and tackle the bricks more effectively.'
  }
];
