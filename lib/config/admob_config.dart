import 'dart:io';

class AdmobConfig {

  /// add status
  static bool bannerAdEnable = true; // "true" for enable and "false" for disable

  /// for home screen banner add
  static String get bannerAdUnitIdHome {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // banner-1 ad id for android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // banner-1 ad id for ios
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // reward ad id for android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // reward ad id for ios
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}