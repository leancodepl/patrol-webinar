import 'package:flutter/foundation.dart';

enum AppPlatform {
  android,
  ios,
  web,
  androidWeb,
  iosWeb,
  other;

  bool get isWeb => [web, androidWeb, iosWeb].contains(this);
  bool get isDesktopWeb => this == web;
  bool get isMobileWeb => [iosWeb, androidWeb].contains(this);

  bool get isAndroid => [android, androidWeb].contains(this);
  bool get isIos => [ios, iosWeb].contains(this);
  bool get isMobile => [android, ios].contains(this);

  static AppPlatform get platform {
    if (kIsWeb) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return iosWeb;
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return androidWeb;
      } else {
        return web;
      }
    } else {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return ios;
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        return android;
      } else {
        return other;
      }
    }
  }
}
