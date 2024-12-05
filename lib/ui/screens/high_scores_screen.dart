import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:brick_breaker/ui/reusable/list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../services/score_service.dart';

class HighScoresScreen extends StatelessWidget {

  const HighScoresScreen({super.key});

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
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: ButtonWidget(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        width: 55,
                        height: 55,
                        icon: 'assets/icons/back.png',
                        btnType: ButtonType.icon2),
                  ),
                  Text(
                    'HighScores',
                    style: TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontFamily: AppTheme.primaryFont,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 66.w,
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Score>>(
                  future: ScoreService.loadScores(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Text('Loading...', style: TextStyle(fontFamily: AppTheme.primaryFont,fontSize: 24.sp,color: AppTheme.primaryTextColor),));
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Something went wrong!', style: TextStyle(fontFamily: AppTheme.primaryFont,fontSize: 24.sp,color: AppTheme.primaryTextColor),));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No scores available', style: TextStyle(fontFamily: AppTheme.primaryFont,fontSize: 24.sp,color: AppTheme.primaryTextColor),));
                    } else {
                      final scores = snapshot.data!;
                      return ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final score = scores[index];
                          return ListItemWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2.w),
                                          decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(16.r)),
                                          child: SizedBox(
                                            width: 42.w,height: 42.w,
                                            child: Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                    fontFamily:
                                                    AppTheme.primaryFont,
                                                    color:
                                                    AppTheme.primaryTextColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 24.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        index < 3 ? Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: EdgeInsets.only(top:8.w),
                                              child: Image.asset('assets/images/${index == 0? 'gold' : index == 1 ? 'silver' : 'bronze'}.png', width: 45.w,height: 45.w,),
                                            ),
                                        ): const SizedBox.shrink()
                                      ],
                                    ),
                                    20.horizontalSpace,
                                    Text(
                                      '${score.score}',
                                      style: TextStyle(
                                          fontFamily: AppTheme.primaryFont,
                                          color: index > 2 ? AppTheme.primaryTextColor : Colors.yellow,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28.sp),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 6.w),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/star.png',
                                        width: 20.w,
                                        height: 20.w,
                                      ),
                                      4.horizontalSpace,
                                      Text(
                                          '${score.stars}',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: AppTheme.primaryFont,
                                              color: AppTheme.primaryTextColor,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Text(
                                    DateFormat('dd MMM').format(DateTime.parse(score.date)),
                                    style: TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontFamily: AppTheme.primaryFont,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
