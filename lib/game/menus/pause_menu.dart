import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:brick_breaker/ui/reusable/alert_window_shape.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:brick_breaker/ui/reusable/window_title_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui/screens/help_alert.dart';
import '../managers/audio_manager.dart';

class PauseMenu extends StatefulWidget {
  // Reference to parent game.
  final BrickBreakerWorld game;
  const PauseMenu({super.key, required this.game});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  final audioManger = AudioManager();

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 16.w,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      height: (MediaQuery.of(context).size.width - 36) * 1.1195652173913044,
                      child: CustomPaint(
                        painter: WindowShape(),
                        child: Padding(
                          padding: EdgeInsets.only(top:16.w,bottom: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  ButtonWidget(
                                    width: 200,
                                    height: 60,
                                    btnType: ButtonType.long1,
                                    onTap: () {
                                      widget.game.overlays.remove('Pause');
                                      widget.game.resumeEngine();
                                    },
                                    text: 'Resume',
                                    icon: 'assets/icons/play.png',
                                  ),
                                  20.verticalSpace,
                                  ButtonWidget(
                                    width: 200,
                                    height: 60,
                                    btnType: ButtonType.long2,
                                    onTap: () {
                                      widget.game.resetGame();
                                      widget.game.overlays.remove('Pause');
                                      widget.game.resumeEngine();
                                    },
                                    text: 'Restart',
                                    icon: 'assets/icons/reload.png',
                                  ),
                                  20.verticalSpace,
                                  ButtonWidget(
                                    width: 200,
                                    height: 60,
                                    btnType: ButtonType.long3,
                                    onTap: () {
                                      widget.game.resetGame();
                                      widget.game.pauseEngine();
                                      widget.game.overlays.remove('Pause');
                                      Navigator.pop(context);
                                    },
                                    text: 'Home',
                                    icon: 'assets/icons/home.png',
                                  ),
                                ],
                              ),
                              24.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonWidget(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          barrierColor: Colors.black.withOpacity(0.5),
                                          builder: (_) => const Center(child: HelpAlert()),
                                        );
                                      },
                                      width: 55,
                                      height: 55,
                                      icon: 'assets/icons/info.png',
                                      btnType: ButtonType.icon3),
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomPaint(
                  size: Size(
                      400,
                      (200 * 0.25133689839572193).toDouble()),
                  painter: WindowTitleShape(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 36.w),
                    child: Text(
                      'PAUSED',
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
      ),
    );
  }
}
