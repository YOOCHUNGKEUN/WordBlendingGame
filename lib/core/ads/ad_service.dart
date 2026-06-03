import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdService {
  AdService._();

  static final AdService instance = AdService._();

  static const String unlockCode = 'wordpang-free';
  static const String _adsDisabledKey = 'ads_disabled';
  static const String _androidTestRewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _androidReleaseRewardedAdUnitId =
      'ca-app-pub-4656509147076490/7240617803';
  static const String _iosTestRewardedAdUnitId =
      'ca-app-pub-3940256099942544/1712485313';

  SharedPreferences? _preferences;
  RewardedAd? _rewardedAd;
  bool _isInitialized = false;
  bool _isLoadingRewardedAd = false;

  bool get areAdsDisabled => _preferences?.getBool(_adsDisabledKey) ?? false;

  bool get _isSupportedPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  String get _rewardedAdUnitId {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _iosTestRewardedAdUnitId;
    }
    if (kDebugMode) {
      return _androidTestRewardedAdUnitId;
    }
    return _androidReleaseRewardedAdUnitId;
  }

  Future<void> initialize({SharedPreferences? preferences}) async {
    _preferences = preferences ?? await SharedPreferences.getInstance();
    if (!_isSupportedPlatform || _isInitialized || areAdsDisabled) return;

    await MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        maxAdContentRating: MaxAdContentRating.g,
        tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
      ),
    );
    await MobileAds.instance.initialize();
    _isInitialized = true;
    loadRewardedHintAd();
  }

  Future<void> setAdsDisabled(bool value) async {
    await _preferences?.setBool(_adsDisabledKey, value);
    if (value) {
      _rewardedAd?.dispose();
      _rewardedAd = null;
      _isLoadingRewardedAd = false;
    } else {
      loadRewardedHintAd();
    }
  }

  bool isValidUnlockCode(String code) {
    return code.trim().toLowerCase() == unlockCode;
  }

  void loadRewardedHintAd() {
    if (areAdsDisabled) return;
    if (!_isSupportedPlatform || !_isInitialized) return;
    if (_isLoadingRewardedAd || _rewardedAd != null) return;

    _isLoadingRewardedAd = true;
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoadingRewardedAd = false;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded hint ad failed to load: $error');
          _rewardedAd = null;
          _isLoadingRewardedAd = false;
        },
      ),
    );
  }

  void showRewardedHintAd({
    required VoidCallback onRewardEarned,
    required VoidCallback onAdUnavailable,
  }) {
    if (areAdsDisabled) {
      onRewardEarned();
      return;
    }

    if (!_isSupportedPlatform || !_isInitialized) {
      onAdUnavailable();
      return;
    }

    final ad = _rewardedAd;
    if (ad == null) {
      loadRewardedHintAd();
      onAdUnavailable();
      return;
    }

    var rewardEarned = false;
    _rewardedAd = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedHintAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded hint ad failed to show: $error');
        ad.dispose();
        loadRewardedHintAd();
        if (!rewardEarned) {
          onAdUnavailable();
        }
      },
    );
    ad.setImmersiveMode(true);
    ad.show(
      onUserEarnedReward: (ad, reward) {
        rewardEarned = true;
        onRewardEarned();
      },
    );
  }
}
