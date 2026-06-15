import 'package:firebase_core/firebase_core.dart';

/// Initializes the default Firebase app for the host application.
///
/// Call once during app startup, before resolving any Firebase-backed services
/// (FCM, Crashlytics, Remote Config, etc.) from DI.
///
/// When [options] is omitted, platform config files are used
/// (`google-services.json` on Android, `GoogleService-Info.plist` on iOS).
Future<FirebaseApp> initializeFirebaseApp({FirebaseOptions? options}) async {
  if (Firebase.apps.isNotEmpty) {
    return Firebase.app();
  }

  if (options != null) {
    return Firebase.initializeApp(options: options);
  }

  return Firebase.initializeApp();
}
