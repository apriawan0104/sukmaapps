import 'package:app_core/app_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Top-level handler required by [FirebaseMessaging.onBackgroundMessage].
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await initializeFirebaseApp();
}

void registerPushNotificationBackgroundHandler() {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}
