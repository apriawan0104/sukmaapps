import 'package:app_core/app_core.dart';

abstract class PushNotificationRemoteDataSource {
  Future<ValueGuard<void>> initialize({
    required OnForegroundNotificationCallback onForegroundNotification,
    required OnNotificationTappedCallback onNotificationTapped,
  });

  Future<ValueGuard<bool>> requestPermission();

  Future<ValueGuard<String>> getToken();

  Future<ValueGuard<void>> deleteToken();

  Future<ValueGuard<NotificationDataEntity?>> getInitialNotification();

  Future<ValueGuard<void>> initializeLocalNotifications({
    required OnLocalNotificationTappedCallback onNotificationTapped,
  });

  Future<ValueGuard<void>> requestLocalPermission();

  Future<ValueGuard<void>> createDefaultChannel();

  Future<ValueGuard<void>> showLocalNotification(NotificationDataEntity notification);

  Stream<NotificationDataEntity> get onNotificationTap;

  Stream<NotificationDataEntity> get onLocalNotificationTap;

  Stream<NotificationDataEntity> get onForegroundNotification;

  Stream<String> get onTokenRefresh;
}
