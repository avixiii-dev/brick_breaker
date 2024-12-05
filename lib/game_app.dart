import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ui/screens/home_screen.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Brick Breaker',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        });
  }
}