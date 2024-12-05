import 'dart:io';

import 'package:brick_breaker/config/app_config.dart';
import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/ui/screens/help_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../game/managers/audio_manager.dart';
import '../reusable/buttons/button_widget.dart';
import '../reusable/window_title_shape.dart';

class SettingsAlert extends StatefulWidget {
  const SettingsAlert({super.key});

  @override
  State<SettingsAlert> createState() => _SettingsAlertState();
}

class _SettingsAlertState extends State<SettingsAlert> {
  final audioManger = AudioManager();

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
                          colors: [AppTheme.bgColor2, AppTheme.bgColor1], radius: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 45.w,),
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
                        36.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                audioManger.isMute ? ButtonWidget(
                                    onTap: () {
                                      audioManger.toggleSound();
                                      setState(() {});
                                    },
                                    width: 55,
                                    height: 55,
                                    icon: 'assets/icons/sound_off.png',
                                    disabled: true,
                                    btnType: ButtonType.icon2) : ButtonWidget(
                                    onTap: () {
                                      audioManger.toggleSound();
                                      setState(() {});
                                    },
                                    width: 55,
                                    height: 55,
                                    icon: 'assets/icons/sound.png',
                                    btnType: ButtonType.icon2),
                                8.verticalSpace,
                                Text(
                                  'Sound',
                                  style: TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ButtonWidget(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierColor: Colors.black.withOpacity(0.5),
                                        builder: (_) => const Center(
                                            child: HelpAlert()
                                        ),
                                      );
                                    },
                                    width: 55,
                                    height: 55,
                                    icon: 'assets/icons/info.png',
                                    btnType: ButtonType.icon3),
                                8.verticalSpace,
                                Text(
                                  'Help',
                                  style: TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ButtonWidget(
                                    onTap: () async {
                                      final String url = Platform.isIOS ? AppConfig.appStoreUrl : AppConfig.playStoreUrl;
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      }
                                    },
                                    width: 55,
                                    height: 55,
                                    icon: 'assets/icons/star.png',
                                    btnType: ButtonType.icon2),
                                8.verticalSpace,
                                Text(
                                  'Rate',
                                  style: TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                        36.verticalSpace,
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                              color: Colors.black.withOpacity(0.3)
                          ),
                          child: Column(
                            children: [
                              Text(
                                'About',
                                style: TextStyle(
                                    color: AppTheme.primaryTextColor,
                                    fontFamily: AppTheme.primaryFont,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                AppConfig.about,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppTheme.primaryTextColor,
                                    fontFamily: AppTheme.primaryFont,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        36.verticalSpace,
                        Text(
                          AppConfig.version,
                          style: TextStyle(
                              color: AppTheme.primaryTextColor.withOpacity(0.7),
                              fontFamily: AppTheme.primaryFont,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
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
                    'Settings',
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
