import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

class AppTheme {
  static const CupertinoThemeData cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    barBackgroundColor: Color(0xFFFDFDFF),
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.textPrimary,
    ),
  );
}
