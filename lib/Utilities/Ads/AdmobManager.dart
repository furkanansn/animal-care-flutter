import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobManager {
  void initializeAdmob() {
    MobileAds.instance.initialize();
  }

  AdWidget bannerAd() {
    final bannerAd = BannerAd(
      adUnitId: '<ad unit id>',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    bannerAd.load();
    return AdWidget(ad: bannerAd);
  }

  void interstitialAd() {
    final intAd = InterstitialAd.load(
        adUnitId: 'ca-app-pub-4849538974269368/3686473961',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void rewardedAd() {
    RewardedAd _rewardedAd;
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
    _rewardedAd.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {});
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
  }
}
