import 'package:flutter/foundation.dart';

import '../../core/services/local_preferences_service.dart';

class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider({required this.preferencesService});

  final LocalPreferencesService preferencesService;

  Future<bool> isCompleted() => preferencesService.isOnboardingDone();

  Future<void> complete() => preferencesService.setOnboardingDone();
}
