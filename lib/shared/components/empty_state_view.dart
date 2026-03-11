import 'package:flutter/cupertino.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: CupertinoColors.systemGrey),
      ),
    );
  }
}
