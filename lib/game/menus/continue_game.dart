import 'dart:async';
import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:brick_breaker/ui/reusable/alert_window_shape.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:brick_breaker/ui/reusable/reward_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../services/score_service.dart';
import '../../services/shop_service.dart';
import '../../ui/reusable/button_animator.dart';

class ContinueGame extends StatefulWidget {
  final BrickBreakerWorld game;

  const ContinueGame({super.key, required this.game});

  @override
  State<ContinueGame> createState() => _ContinueGameState();
}

class _ContinueGameState extends State<ContinueGame> {
  final RewardAd rewardAd = RewardAd();
  late Timer _timer;
  double _progress = 1.0; // Start with full progress
  int _remainingTime = 15; // 10 seconds countdown

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        _progress = _remainingTime / 15;

        if (_remainingTime == 0) {
          _timer.cancel();
          widget.game.overlays.remove('ContinueGame');
          widget.game.overlays.add('GameOver');
          saveResult();
        }
      });
    });
  }

  // save final result
  saveResult() {
    final Score newScore = Score(widget.game.topBar.score,
        DateTime.now().toString(), widget.game.topBar.starCount);
    if (widget.game.topBar.score > 0) {
      ScoreService.saveScore(newScore);
    }
    if (widget.game.topBar.starCount > 0) {
      ShopService.saveStarCount(widget.game.topBar.starCount);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 36,
          height: (MediaQuery.of(context).size.width - 36) * 1.1195652173913044,
          child: CustomPaint(
            painter: WindowShape(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h, right: 20.w, bottom: 20.h),
                        child: ButtonWidget(
                            onTap: () {
                              widget.game.overlays.remove('ContinueGame');
                              widget.game.overlays.add('GameOver');
                              saveResult();
                            },
                            width: 45,
                            height: 45,
                            icon: 'assets/icons/cross.png',
                            btnType: ButtonType.icon3),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 120.w,
                          child: CircularProgressIndicator(
                            value: _progress, // Update progress
                            strokeWidth: 10.0,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Colors.white.withOpacity(0.4),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryBtnColor2),
                          ),
                        ),
                        Image.asset(
                          'assets/icons/video.png',
                          width: 50.w,
                          height: 50.w,
                          color: AppTheme.fgColor2,
                        )
                      ],
                    ),
                    20.verticalSpace,
                    Text(
                      'Watch an ad & continue',
                      style: TextStyle(
                          fontFamily: AppTheme.primaryFont,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.primaryTextColor),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 36.h),
                  child: ButtonAnimator(
                    animationDuration: 200,
                    recurrentDuration: 1000,
                    child: rewardAd.rewardedAd != null
                        ? ButtonWidget(
                            onTap: () {
                              _timer.cancel();
                              rewardAd.rewardedAd?.show(onUserEarnedReward:
                                  (AdWithoutView ad, RewardItem rewardItem) {
                                widget.game.resumeGame();
                              });
                            },
                            width: 200,
                            height: 60,
                            text: 'Continue',
                            icon: 'assets/icons/video.png',
                            btnType: ButtonType.long1)
                        : Padding(
                            padding: EdgeInsets.only(bottom: 30.w),
                            child: Text(
                              'Loading Ad',
                              style: TextStyle(
                                  fontFamily: AppTheme.primaryFont,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.primaryTextColor),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
