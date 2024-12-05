import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:brick_breaker/ui/reusable/alert_window_shape.dart';
import 'package:brick_breaker/ui/reusable/button_animator.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:brick_breaker/ui/reusable/reward_ad_widget.dart';
import 'package:brick_breaker/ui/reusable/window_title_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../services/shop_service.dart';

class GameOver extends StatefulWidget {

  final BrickBreakerWorld game;

  const GameOver({super.key, required this.game});

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  final RewardAd rewardAd = RewardAd();
  int starCount = 0;

  @override
  void initState() {
    starCount = widget.game.topBar.starCount;
    super.initState();
  }

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
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset('assets/images/win.png',),
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox.shrink(),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Text(
                                          '${widget.game.topBar.score}',
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 48.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          Container(
                                            width: 180.w,
                                            padding: EdgeInsets.only(left: 16.w,right: 16.w,top: 4.w,bottom: 4.w),
                                            decoration: BoxDecoration(
                                              gradient: const RadialGradient(
                                                radius: 2,
                                                colors: [AppTheme.fgColor2,AppTheme.fgColor1]
                                              ),
                                              boxShadow: [
                                                BoxShadow(color: Colors.black.withOpacity(0.4),spreadRadius: 1,blurRadius: 3,offset: const Offset(2,2))
                                              ],
                                              borderRadius: BorderRadius.circular(24.r)
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$starCount',
                                                style: TextStyle(
                                                  color: AppTheme.primaryTextColor,
                                                  fontSize: 24.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Image.asset('assets/images/star.png')
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            ButtonWidget(
                                                width: 55,
                                                height: 55,
                                                btnType: ButtonType.icon3,
                                                onTap: () {
                                                  widget.game.resetGame();
                                                  widget.game.overlays.remove('GameOver');
                                                  Navigator.pop(context);
                                                },
                                                icon: 'assets/icons/home.png'),
                                            8.verticalSpace,
                                            Text(
                                              'Home',
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
                                            ButtonAnimator(
                                              child: ButtonWidget(
                                                  width: 80,
                                                  height: 80,
                                                  btnType: ButtonType.icon1,
                                                  onTap: () {
                                                    widget.game.resetGame();
                                                    widget.game.overlays.remove('GameOver');
                                                    widget.game.resumeEngine();
                                                  },
                                                  icon: 'assets/icons/reload.png'),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              'Replay',
                                              style: TextStyle(
                                                  color: AppTheme.primaryTextColor,
                                                  fontFamily: AppTheme.primaryFont,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        widget.game.topBar.starCount > 0 ? Column(
                                          children: [
                                            ButtonWidget(
                                                width: 55,
                                                height: 55,
                                                btnType: ButtonType.icon2,
                                                onTap: () {
                                                  rewardAd.rewardedAd?.show(
                                                      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
                                                        setState(() {
                                                          starCount = starCount*2;
                                                        });
                                                        ShopService.saveStarCount(widget.game.topBar.starCount);
                                                      });
                                                },
                                                icon: 'assets/icons/video.png'),
                                            8.verticalSpace,
                                            Text(
                                              '⭐x2',
                                              style: TextStyle(
                                                  color: AppTheme.primaryTextColor,
                                                  fontFamily: AppTheme.primaryFont,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ) : const SizedBox.shrink(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
                      'GAME OVER',
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
