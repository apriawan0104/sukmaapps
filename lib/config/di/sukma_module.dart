import 'package:app_core/app_core.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import '../../features/auth/data/datasource/local/auth_local.datasource.dart';
import 'session_token_provider.service.dart';

@module
abstract class SukmaModule {
  bool get _isNonProd => EnvConstant.environment.env != FlavorType.prd.name;

  String? get _googleWebClientId {
    if (!kIsWeb) return null;

    final clientId = EnvConstant.googleWebClientId.env;
    if (clientId.isEmpty || clientId == '-') return null;

    return clientId;
  }

  @lazySingleton
  RemoteConfigConfig get remoteConfigConfig => RemoteConfigConfig(
        defaults: {
          VersionUpdateConstant.latestAppVersionsKey: '{}',
        },
      );

  @lazySingleton
  NetworkConfig get networkConfig => NetworkConfig(
        baseUrl: EnvConstant.baseUrl.env,
        enableLogging: _isNonProd,
        dioInterceptors: _isNonProd ? [ChuckerDioInterceptor()] : const [],
      );

  @lazySingleton
  @Named('googleAuth')
  AuthenticationService googleAuthService() =>
      GoogleAuthenticationServiceImpl(
        clientId: _googleWebClientId,
      );

  @lazySingleton
  @Named('appleAuth')
  AuthenticationService appleAuthService() => AppleAuthenticationServiceImpl();

  @lazySingleton
  TokenProviderService tokenProvider(AuthLocalDataSource localDataSource) =>
      SessionTokenProviderService(localDataSource);

  @preResolve
  @Named(TableConstant.tbMUser)
  @lazySingleton
  Future<StorageService> tbMUserStorage() async {
    final storage = HiveStorageServiceImpl(boxName: TableConstant.tbMUser);
    final result = await storage.initialize();

    return result.fold(
      (failure) => throw Exception(
        'Storage initialization failed: ${failure.message}',
      ),
      (_) => storage,
    );
  }
}
