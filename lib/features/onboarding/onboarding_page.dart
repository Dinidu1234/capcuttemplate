import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../shell/main_shell_page.dart';
import 'onboarding_provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> finish() async {
      await context.read<OnboardingProvider>().complete();
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (_) => const MainShellPage()),
      );
    }

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text('Welcome to Cap Template', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Discover, save, and launch CapCut templates quickly.'),
              const Spacer(),
              CupertinoButton.filled(onPressed: finish, child: const Text('Get Started')),
              CupertinoButton(onPressed: finish, child: const Text('Skip')),
            ],
          ),
        ),
      ),
    );
  }
}
