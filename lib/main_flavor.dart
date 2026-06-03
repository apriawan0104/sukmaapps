import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';

enum AppFlavor { dev, uat, prd }

String _envFileName(AppFlavor flavor) {
  return switch (flavor) {
    AppFlavor.dev => '.env.dev',
    AppFlavor.uat => '.env.uat',
    AppFlavor.prd => '.env',
  };
}

/// Loads the env file for this flavor, then calls [runApp].
Future<void> runSukmaApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await dotenv.load(fileName: _envFileName(flavor));
  configureEnvironmentFromDotenv();
  runApp(ProviderScope(child: SukmaApp(flavor: flavor)));
}

class SukmaApp extends StatelessWidget {
  const SukmaApp({required this.flavor, super.key});

  final AppFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return AppScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: _appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }

  String get _appTitle {
    switch (flavor) {
      case AppFlavor.dev:
        return 'Sukma Dev';
      case AppFlavor.uat:
        return 'Sukma Uat';
      case AppFlavor.prd:
        return 'Sukma';
    }
  }
}
