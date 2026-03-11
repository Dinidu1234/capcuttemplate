import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferencesService {
  static const _onboardingKey = 'onboarding_done';
  static const _favoriteIdsKey = 'favorite_ids';

  Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<Set<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_favoriteIdsKey) ?? <String>[]).toSet();
  }

  Future<void> saveFavoriteIds(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteIdsKey, ids.toList());
  }
}
