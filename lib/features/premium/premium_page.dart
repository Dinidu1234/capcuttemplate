import 'package:flutter/cupertino.dart';

import '../../shared/dialogs/coming_soon_dialog.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget card(String title, String subtitle) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(subtitle),
          ],
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Premium')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Upgrade to Premium', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            card('No Ads', 'Enjoy a distraction-free experience.'),
            card('Exclusive Templates', 'Unlock curated premium packs.'),
            card('Priority Access', 'Get newly added templates first.'),
            const SizedBox(height: 12),
            CupertinoButton.filled(
              onPressed: () => showComingSoonDialog(context, 'Monthly Plan'),
              child: const Text('Monthly - Placeholder'),
            ),
            const SizedBox(height: 10),
            CupertinoButton.filled(
              onPressed: () => showComingSoonDialog(context, 'Yearly Plan'),
              child: const Text('Yearly - Placeholder'),
            ),
            CupertinoButton(
              onPressed: () => showComingSoonDialog(context, 'Restore Purchases'),
              child: const Text('Restore Purchases'),
            ),
          ],
        ),
      ),
    );
  }
}
