import 'package:app_core/app_core.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'common/common.dart';
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
  _configureChucker(flavor);
  await initializeFirebaseApp();
  await dotenv.load(fileName: _envFileName(flavor));
  await configureDependencies();
  configureEnvironmentFromDotenv();
  registerPushNotificationBackgroundHandler();
  appRouter = createAppRouter(
    observers:
        flavor == AppFlavor.prd ? const [] : [ChuckerFlutter.navigatorObserver],
  );
  runApp(
    ProviderScope(
      child: PushNotificationBootstrap(
        child: VersionCheckBootstrap(
          child: SukmaApp(flavor: flavor),
        ),
      ),
    ),
  );
}

void _configureChucker(AppFlavor flavor) {
  if (flavor == AppFlavor.prd) {
    return;
  }

  ChuckerFlutter.showOnRelease = false;
  ChuckerFlutter.showNotification = true;
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
        theme: AppTheme.light,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return UIBannerEnv.banner(
            EnvironmentConfig.current,
            MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            ),
          );
        },
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
