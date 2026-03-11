import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/services/local_preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/template_repository.dart';
import 'data/sources/template_local_source.dart';
import 'data/sources/template_remote_source.dart';
import 'data/storage/app_database.dart';
import 'features/favorites/favorites_provider.dart';
import 'features/home/home_provider.dart';
import 'features/onboarding/onboarding_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = LocalPreferencesService();
  final database = AppDatabase();
  final remoteSource = TemplateRemoteSource(client: http.Client());
  final localSource = TemplateLocalSource(appDatabase: database);
  final repository = TemplateRepository(
    remoteSource: remoteSource,
    localSource: localSource,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(repository: repository),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              FavoritesProvider(preferencesService: preferencesService)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(preferencesService: preferencesService),
        ),
      ],
      child: const CapTemplateApp(),
    ),
  );
}

class CapTemplateApp extends StatelessWidget {
  const CapTemplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.cupertinoTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
