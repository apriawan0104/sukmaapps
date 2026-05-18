import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote.datasource.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteImplDataSource implements AuthRemoteDataSource {
  AuthRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;
  final AuthenticationService _googleAuthenticationService =
      GoogleAuthenticationServiceImpl();
  final AuthenticationService _appleAuthenticationService =
      AppleAuthenticationServiceImpl();

  @override
  Future<ValueGuard<void>> loginGoogle(NoParams params) async {
    return _googleAuthenticationService.signInWithGoogle().mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> loginApple(NoParams params) async {
    return _appleAuthenticationService.signInWithApple().mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> readTerm(NoParams params) async {
    return _remoteClient.get<void>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }
}
