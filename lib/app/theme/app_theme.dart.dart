import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColor.whiteMassive,
    appBarTheme: const AppBarTheme().copyWith(
      color: AppColor.whiteMassive,
    ),
  );
}
