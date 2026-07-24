import 'package:app_core/app_core.dart';

import '../../../config/di/locator.dart';
import '../../../features/auth/data/datasource/local/auth_local.datasource.dart';

/// Safely attaches user context to Crashlytics.
///
/// Missing values are sent as empty strings. Failures are swallowed so this
/// never blocks login, logout, or app startup.
class CrashlyticsUserContext {
  const CrashlyticsUserContext._();

  static Future<void> setUser({
    String? userId,
    String? email,
    String? name,
  }) async {
    try {
      final crashReporter = getIt<CrashReporterService>();
      await Future.wait<void>([
        _ignore(crashReporter.setUserIdentifier(userId ?? '')),
        _ignore(crashReporter.setUserEmail(email ?? '')),
        _ignore(crashReporter.setUserName(name ?? '')),
      ]);
    } catch (_) {
      // Crashlytics must never break app flow.
    }
  }

  static Future<void> clear() => setUser(userId: '', email: '', name: '');

  /// Restores Crashlytics user context from the local session (cold start).
  static Future<void> syncFromLocalSession() async {
    try {
      final authLocal = getIt<AuthLocalDataSource>();
      final userId = (await authLocal.getUserId()).fold(
        (_) => '',
        (value) => value ?? '',
      );
      final name = (await authLocal.getName()).fold(
        (_) => '',
        (value) => value ?? '',
      );
      final email = (await authLocal.getEmail()).fold(
        (_) => '',
        (value) => value ?? '',
      );

      if (userId.trim().isEmpty) {
        await clear();
        return;
      }

      await setUser(userId: userId, email: email, name: name);
    } catch (_) {
      // Crashlytics must never break app flow.
    }
  }

  static Future<void> _ignore(Future<dynamic> future) async {
    try {
      await future;
    } catch (_) {
      // Ignore provider failures and unexpected exceptions.
    }
  }
}
