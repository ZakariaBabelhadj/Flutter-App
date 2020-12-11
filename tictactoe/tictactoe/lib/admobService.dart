import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7964541967487235~6146395356';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7964541967487235/9099861758';
    }
    return null;
  }
}
