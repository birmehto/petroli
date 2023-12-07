import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-7323067121097339/6549617972',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // Handle ad loaded event
        },
      ),
    );
  }
}
