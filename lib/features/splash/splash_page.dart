import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../onboarding/onboarding_provider.dart';
import '../shell/main_shell_page.dart';
import '../onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    final completed = await context.read<OnboardingProvider>().isCompleted();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (_) => completed ? const MainShellPage() : const OnboardingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(AppConstants.appName, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              CupertinoActivityIndicator(radius: 14),
            ],
          ),
        ),
      ),
    );
  }
}
