import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import 'push_notification_local.datasource.dart';

@LazySingleton(as: PushNotificationLocalDataSource)
class PushNotificationLocalImplDataSource
    implements PushNotificationLocalDataSource {
  PushNotificationLocalImplDataSource(
    @Named(TableConstant.tbMUser) this._storage,
  );

  final StorageService _storage;

  @override
  Future<ValueGuard<void>> saveFcmToken(String token) async {
    final result = await _storage.save(UserKeyConstant.keyTokenFcm, token);
    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<void>> removeFcmToken() async {
    final result = await _storage.delete(UserKeyConstant.keyTokenFcm);
    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<String?>> getFcmToken() async {
    final result = await _storage.get<String>(UserKeyConstant.keyTokenFcm);
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<String?>> getUserId() async {
    final result = await _storage.get<String>(UserKeyConstant.keyUserID);
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<String?>> getToken() async {
    final result = await _storage.get<String>(UserKeyConstant.keyToken);
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }
}
