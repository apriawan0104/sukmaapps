import 'package:app_core/app_core.dart';

abstract class AuthLocalDataSource {
  Future<ValueGuard<String?>> getFcmToken();

  Future<ValueGuard<String?>> getUserId();

  Future<ValueGuard<String?>> getName();

  Future<ValueGuard<String?>> getFoto();

  Future<ValueGuard<String?>> getToken();

  Future<ValueGuard<void>> clearSession();

  Future<ValueGuard<void>> saveSession({
    required String userId,
    required String? fullname,
    required String? foto,
    required String? token,
  });
}
