import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Use bundled Plus Jakarta Sans assets; do not download fonts at runtime.
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Chucker on for all modes on dev/uat, and debug-only on prd.
  // Hidden for prd profile + prd release (button, notification, inspector).
  ChuckerConfig.configure(
    enabled: flavor != AppFlavor.prd || kDebugMode,
  );
  await initializeFirebaseApp();
  await dotenv.load(fileName: _envFileName(flavor));
  await configureDependencies();
  configureEnvironmentFromDotenv();

  final crashReporter = getIt<CrashReporterService>();
  await crashReporter.initialize();
  // Best-effort; must not block startup if session/user data is missing.
  await CrashlyticsUserContext.syncFromLocalSession();

  FlutterError.onError = (details) {
    crashReporter.recordFlutterError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    crashReporter.recordError(
      exception: error,
      stackTrace: stack,
      fatal: true,
    );
    return true;
  };

  registerPushNotificationBackgroundHandler();
  appRouter = createAppRouter(
    observers: ChuckerConfig.navigatorObservers,
  );
  runZonedGuarded(
    () => runApp(
      ProviderScope(
        child: PushNotificationBootstrap(
          child: VersionCheckBootstrap(
            child: SukmaApp(flavor: flavor),
          ),
        ),
      ),
    ),
    (error, stack) {
      crashReporter.recordError(
        exception: error,
        stackTrace: stack,
        fatal: true,
      );
    },
  );
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
          return ChuckerConfig.enableGlobalLongPress(
            child: UIBannerEnv.banner(
              EnvironmentConfig.current,
              MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              ),
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
