import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/common/presentation/helper/crashlytics_user_context.dart';

import '../../domain/domain.dart';
import '../datasource/datasource.dart';
@LazySingleton(as: AuthRepository)
class AuthImplRepository implements AuthRepository {
  AuthImplRepository(
    this._remoteDataSource,
    this._localDataSource,
    this._firebaseMessagingService,
    @Named('googleAuth') this._googleAuth,
    @Named('appleAuth') this._appleAuth,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final FirebaseMessagingService _firebaseMessagingService;
  final AuthenticationService _googleAuth;
  final AuthenticationService _appleAuth;

  @override
  Future<ValueGuard<UserEntity>> loginGoogle(NoParams params) {
    return _login(() => _remoteDataSource.signInWithGoogle(params));
  }

  @override
  Future<ValueGuard<UserEntity>> loginApple(NoParams params) {
    return _login(() => _remoteDataSource.signInWithApple(params));
  }

  Future<ValueGuard<UserEntity>> _login(
    Future<ValueGuard<AuthCredentials>> Function() signIn,
  ) async {
    final credentialsResult = await signIn();

    return credentialsResult.flatMapAsync((credentials) async {
      final accessId = _resolveAccessId(credentials);
      if (accessId.isEmpty) {
        return ValueGuards.failure(
          const AuthenticationFailure('User ID tidak ditemukan'),
        );
      }

      final user = credentials.user;
      final tokenFcm = (await _localDataSource.getFcmToken()).fold(
        (_) => null,
        (value) => value,
      );

      final registerResult = await _remoteDataSource.register(
        RegisterParam(
          accessId: accessId,
          fullname: user.displayName,
          tokenFcm: tokenFcm,
        ),
      );

      return registerResult.flatMapAsync((userModel) async {
        final email = userModel.user?.email ?? user.email ?? '';
        final saveResult = await _localDataSource.saveSession(
          userId: accessId,
          fullname: userModel.user?.fullname ?? '',
          email: email,
          foto: user.photoUrl ?? '',
          token: userModel.token,
        );

        return saveResult.flatMapAsync((_) async {
          final entity = userModel.toEntity();
          await CrashlyticsUserContext.setUser(
            userId: accessId,
            email: email,
            name: entity.user?.fullname,
          );
          return ValueGuards.success(entity);
        });
      });
    });
  }

  @override
  Future<ValueGuard<UserEntity>> refreshToken(NoParams params) async {
    final userIdResult = await _localDataSource.getUserId();

    return userIdResult.flatMapAsync((userId) async {
      if (userId == null || userId.isEmpty) {
        return ValueGuards.failure(
          const AuthenticationFailure('Session tidak ditemukan'),
        );
      }

      final tokenFcm = (await _localDataSource.getFcmToken()).fold(
        (_) => null,
        (value) => value,
      );
      final foto = (await _localDataSource.getFoto()).fold(
        (_) => null,
        (value) => value,
      );
      final existingEmail = (await _localDataSource.getEmail()).fold(
        (_) => '',
        (value) => value ?? '',
      );

      final registerResult = await _remoteDataSource.register(
        RegisterParam(
          accessId: userId,
          tokenFcm: tokenFcm,
        ),
      );

      return registerResult.flatMapAsync((userModel) async {
        final email = userModel.user?.email ?? existingEmail;
        final saveResult = await _localDataSource.saveSession(
          userId: userId,
          fullname: userModel.user?.fullname,
          email: email,
          foto: foto,
          token: userModel.token,
        );

        return saveResult.flatMapAsync((_) async {
          final entity = userModel.toEntity();
          await CrashlyticsUserContext.setUser(
            userId: userId,
            email: email,
            name: entity.user?.fullname,
          );
          return ValueGuards.success(entity);
        });
      });
    });
  }

  String _resolveAccessId(AuthCredentials credentials) {
    final user = credentials.user;

    return switch (credentials.provider) {
      AuthProvider.google => user.email ?? user.providerUserId ?? user.id,
      AuthProvider.apple => user.providerUserId ?? user.id,
      _ => user.id,
    };
  }

  @override
  Future<ValueGuard<void>> readTerm(NoParams params) async {
    return _remoteDataSource.readTerm(const ReadTermParam());
  }

  @override
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params) async {
    final deleteResult = await _remoteDataSource.deleteAccount(params);
    deleteResult.fold((_) {}, (_) {});

    return _clearSessionAndSignOut();
  }

  @override
  Future<ValueGuard<void>> logout(NoParams params) async {
    return _clearSessionAndSignOut();
  }

  Future<ValueGuard<void>> _clearSessionAndSignOut() async {
    final fcmResult = await _firebaseMessagingService.deleteToken();
    fcmResult.fold((_) {}, (_) {});

    final clearResult = await _localDataSource.clearSession();
    if (clearResult.isLeft()) {
      return clearResult;
    }

    final googleSignOutResult = await _googleAuth.signOut();
    googleSignOutResult.fold((_) {}, (_) {});

    final appleSignOutResult = await _appleAuth.signOut();
    appleSignOutResult.fold((_) {}, (_) {});

    await CrashlyticsUserContext.clear();

    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<LocalUserEntity>> getLocalUser(NoParams params) async {
    final userId = (await _localDataSource.getUserId()).fold(
      (_) => null,
      (value) => value,
    );
    final fullname = (await _localDataSource.getName()).fold(
      (_) => null,
      (value) => value,
    );
    final email = (await _localDataSource.getEmail()).fold(
      (_) => null,
      (value) => value,
    );
    final foto = (await _localDataSource.getFoto()).fold(
      (_) => null,
      (value) => value,
    );

    return ValueGuards.success(
      LocalUserEntity(
        userId: userId ?? '',
        fullname: fullname ?? '',
        email: email ?? '',
        foto: foto ?? '',
      ),
    );
  }
}
