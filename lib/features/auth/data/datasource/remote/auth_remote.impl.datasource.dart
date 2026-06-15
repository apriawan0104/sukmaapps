import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../domain/domain.dart';
import '../../model/model.dart';
import 'auth_remote.datasource.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteImplDataSource implements AuthRemoteDataSource {
  AuthRemoteImplDataSource(
    this._remoteClient,
    @Named('googleAuth') this._googleAuth,
    @Named('appleAuth') this._appleAuth,
  );

  final HttpClient _remoteClient;
  final AuthenticationService _googleAuth;
  final AuthenticationService _appleAuth;

  @override
  Future<ValueGuard<AuthCredentials>> signInWithGoogle(NoParams params) {
    return _googleAuth.signInWithGoogle();
  }

  @override
  Future<ValueGuard<AuthCredentials>> signInWithApple(NoParams params) {
    return _appleAuth.signInWithApple();
  }

  @override
  Future<ValueGuard<UserModel>> register(RegisterParam params) {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.authRegister,
          data: params.toJson(),
        )
        .mapSuccess(
          (response) => UserModel.fromJson(
            ApiResponse.unwrapMap(response.data),
          ),
        );
  }

  @override
  Future<ValueGuard<void>> readTerm(ReadTermParam params) async {
    return _remoteClient
        .post<void>(
          WebServiceConstant.acceptTerm,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params) async {
    return _remoteClient
        .delete<void>(
          WebServiceConstant.accountDelete,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> logout(NoParams params) async {
    return _remoteClient
        .post<void>(
          '/endpointPath',
          queryParameters: const {'ver': 'v1'},
        )
        .mapSuccess((_) {});
  }
}
