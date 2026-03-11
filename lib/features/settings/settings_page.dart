import 'package:flutter/cupertino.dart';

import '../../shared/dialogs/coming_soon_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _row(context, 'App Version', trailing: '1.0.0'),
            _row(context, 'Privacy Policy', onTap: () => showComingSoonDialog(context, 'Privacy Policy')),
            _row(context, 'Terms', onTap: () => showComingSoonDialog(context, 'Terms')),
            _row(context, 'Contact Support', onTap: () => showComingSoonDialog(context, 'Contact Support')),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String title, {String? trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title)),
            if (trailing != null)
              Text(trailing, style: const TextStyle(color: CupertinoColors.systemGrey)),
            if (onTap != null)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(CupertinoIcons.chevron_forward, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
