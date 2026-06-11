import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../datasource/datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthImplRepository implements AuthRepository {
  AuthImplRepository(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<void>> loginGoogle(NoParams params) async {
    return await _remoteDataSource.loginGoogle(params);
  }

  @override
  Future<ValueGuard<void>> loginApple(NoParams params) async {
    return await _remoteDataSource.loginApple(params);
  }

  @override
  Future<ValueGuard<void>> readTerm(NoParams params) async {
    return await _remoteDataSource.readTerm(params);
  }

  @override
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params) async {
    return await _remoteDataSource.deleteAccount(params);
  }

  @override
  Future<ValueGuard<void>> logout(NoParams params) async {
    return await _remoteDataSource.logout(params);
  }
}
