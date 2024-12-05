import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'game/managers/audio_manager.dart';
import 'game_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Flame.device.fullScreen();
  final audioManger = AudioManager();
  audioManger.initialize();
  runApp(const GameApp());
}

