import 'package:app_core/app_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Top-level handler required by [FirebaseMessaging.onBackgroundMessage].
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await initializeFirebaseApp();
}

void registerPushNotificationBackgroundHandler() {
  if (kIsWeb) {
    return;
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
