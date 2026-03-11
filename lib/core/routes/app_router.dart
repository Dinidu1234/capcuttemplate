import 'package:flutter/cupertino.dart';

import '../../features/onboarding/onboarding_page.dart';
import '../../features/shell/main_shell_page.dart';
import '../../features/splash/splash_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return CupertinoPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.shell:
        return CupertinoPageRoute(builder: (_) => const MainShellPage());
      case AppRoutes.splash:
      default:
        return CupertinoPageRoute(builder: (_) => const SplashPage());
    }
  }
}
