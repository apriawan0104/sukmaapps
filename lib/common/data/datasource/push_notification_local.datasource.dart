import 'package:app_core/app_core.dart';

abstract class PushNotificationLocalDataSource {
  Future<ValueGuard<void>> saveFcmToken(String token);

  Future<ValueGuard<void>> removeFcmToken();

  Future<ValueGuard<String?>> getFcmToken();

  Future<ValueGuard<String?>> getUserId();

  Future<ValueGuard<String?>> getToken();
}
