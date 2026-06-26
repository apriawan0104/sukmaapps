import 'package:app_core/app_core.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  if (!kIsWeb) {
    await initializeFirebaseApp();
  }
  await dotenv.load(fileName: _envFileName(flavor));
  await configureDependencies();
  configureEnvironmentFromDotenv();
  if (!kIsWeb) {
    registerPushNotificationBackgroundHandler();
  }
  appRouter = createAppRouter(
    observers:
        flavor == AppFlavor.prd ? const [] : [ChuckerFlutter.navigatorObserver],
  );
  runApp(
    ProviderScope(
      child: PushNotificationBootstrap(
        child: kIsWeb
            ? SukmaApp(flavor: flavor)
            : VersionCheckBootstrap(
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

  static const _designSize = Size(375, 812);

  final AppFlavor flavor;

  @override
  Widget build(BuildContext context) {
    Widget buildMaterialApp(BuildContext context) {
      return MaterialApp.router(
        title: _appTitle,
        theme: AppTheme.light,
        routerConfig: appRouter,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
      );
    }

    final screenUtilInit = AppScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      configureFromInheritedMediaQuery: kIsWeb,
      builder: (context, child) => buildMaterialApp(context),
    );

    if (!kIsWeb) {
      return screenUtilInit;
    }

    return WebMobileFrame(
      frameSize: _designSize,
      backgroundColor: AppColor.whiteHeavy,
      child: screenUtilInit,
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
