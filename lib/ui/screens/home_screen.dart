import 'package:brick_breaker/config/admob_config.dart';
import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/ui/screens/game_screen.dart';
import 'package:brick_breaker/ui/screens/high_scores_screen.dart';
import 'package:brick_breaker/ui/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../reusable/banner_ad_widget.dart';
import '../reusable/button_animator.dart';
import '../reusable/buttons/button_widget.dart';
import 'settings_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_ovelay.png'),
            fit: BoxFit.fill,
          ),
          gradient: RadialGradient(
              colors: [AppTheme.bgColor1, AppTheme.bgColor2], radius: 0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: ButtonWidget(
                    width: 55,
                    height: 55,
                    btnType: ButtonType.icon3,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.6),
                        builder: (_) => const Center(child: SettingsAlert()),
                      );
                    },
                    icon: 'assets/icons/setting.png'),
              ),
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 288 * 0.8.w,
                  height: 220 * 0.8.w,
                ),
                36.verticalSpace,
                ButtonAnimator(
                  animationDuration: 200,
                  recurrentDuration: 1000,
                  child: ButtonWidget(
                    width: 200,
                    height: 60,
                    btnType: ButtonType.long1,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
                    },
                    text: 'Play',
                    icon: 'assets/icons/play.png',
                  ),
                ),
                20.verticalSpace,
                ButtonWidget(
                    width: 190,
                    height: 60,
                    btnType: ButtonType.long2,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopScreen()));
                    },
                    text: 'Shop',
                    icon: 'assets/icons/cart.png'),
                20.verticalSpace,
                ButtonWidget(
                    width: 205,
                    height: 60,
                    btnType: ButtonType.long3,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HighScoresScreen()));
                    },
                    text: 'HighScores',
                    icon: 'assets/icons/trophy.png'),
              ],
            ),
            AdmobConfig.bannerAdEnable ? BannerAdWidget(unitAdId: AdmobConfig.bannerAdUnitIdHome,) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
