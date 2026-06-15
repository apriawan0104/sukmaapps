import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/datasource/local/auth_local.datasource.dart';

/// Reads the backend session token saved from [UserModel.token].
@LazySingleton(as: TokenProviderService)
class SessionTokenProviderService implements TokenProviderService {
  SessionTokenProviderService(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<ValueGuard<String>> getAccessToken() async {
    final result = await _localDataSource.getToken();

    return result.flatMap((token) {
      if (token == null || token.isEmpty) {
        return ValueGuards.failure(
          const AuthenticationFailure('Token tidak ditemukan'),
        );
      }

      return ValueGuards.success(token);
    });
  }

  @override
  Future<ValueGuard<AuthToken>> getAuthToken() async {
    final result = await getAccessToken();

    return result.mapValue(
      (token) => AuthToken(
        accessToken: token,
        tokenType: 'Bearer',
      ),
    );
  }

  @override
  Future<ValueGuard<bool>> hasValidToken() async {
    final result = await getAccessToken();

    return result.fold(
      (_) => ValueGuards.success(false),
      (_) => ValueGuards.success(true),
    );
  }

  @override
  Future<ValueGuard<void>> clearTokens() async {
    final result = await _localDataSource.clearSession();

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<AuthToken>> refreshToken() async {
    return ValueGuards.failure(
      const AuthenticationFailure('Refresh token tidak didukung'),
    );
  }

  @override
  Future<ValueGuard<String?>> getRefreshToken() async {
    return ValueGuards.success(null);
  }
}
