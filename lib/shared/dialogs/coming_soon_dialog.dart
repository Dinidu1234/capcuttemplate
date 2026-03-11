import 'package:flutter/cupertino.dart';

Future<void> showComingSoonDialog(BuildContext context, String title) {
  return showCupertinoDialog<void>(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: const Text('This feature is coming soon.'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
