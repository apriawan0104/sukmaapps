import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import 'auth_local.datasource.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalImplDataSource implements AuthLocalDataSource {
  AuthLocalImplDataSource(
    @Named(TableConstant.tbMUser) this._storage,
  );

  final StorageService _storage;

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
  Future<ValueGuard<String?>> getName() async {
    final result = await _storage.get<String>(UserKeyConstant.keyName);
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<String?>> getEmail() async {
    final result = await _storage.get<String>(UserKeyConstant.keyEmail);
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<String?>> getFoto() async {
    final result = await _storage.get<String>(UserKeyConstant.keyFoto);
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

  @override
  Future<ValueGuard<void>> clearSession() async {
    final result = await _storage.clear();

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<void>> saveSession({
    required String userId,
    required String? fullname,
    required String? email,
    required String? foto,
    required String? token,
  }) async {
    final result = await _storage.saveAll({
      UserKeyConstant.keyUserID: userId,
      UserKeyConstant.keyName: fullname ?? '',
      UserKeyConstant.keyEmail: email ?? '',
      UserKeyConstant.keyFoto: foto,
      UserKeyConstant.keyToken: token,
    });

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }
}
