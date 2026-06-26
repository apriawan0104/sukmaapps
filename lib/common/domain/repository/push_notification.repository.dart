import 'package:app_core/app_core.dart';

abstract class PushNotificationRepository {
  Future<ValueGuard<void>> initialize();

  Future<ValueGuard<void>> syncFcmToken();

  Future<ValueGuard<void>> removeFcmToken();

  Future<ValueGuard<bool>> hasActiveSession();

  Future<ValueGuard<NotificationDataEntity?>> getInitialNotification();

  Stream<NotificationDataEntity> get onNotificationTap;

  Stream<NotificationDataEntity> get onLocalNotificationTap;

  Stream<NotificationDataEntity> get onForegroundNotification;

  Stream<String> get onTokenRefresh;
}
