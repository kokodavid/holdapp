import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> getHasSeenOnboarding();
  Future<void> cacheHasSeenOnboarding();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String hasSeenOnboardingKey = 'HAS_SEEN_ONBOARDING';

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getHasSeenOnboarding() async {
    try {
      return sharedPreferences.getBool(hasSeenOnboardingKey) ?? false;
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return false; // default fallback
    }
  }

  @override
  Future<void> cacheHasSeenOnboarding() async {
    try {
      await sharedPreferences.setBool(hasSeenOnboardingKey, true);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    }
  }
}
