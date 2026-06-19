import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../common/presentation/widget/statics/static.widget.dart';
import '../../core/core.dart';
import '../navigation/navigation.dart';

/// Clears local session and redirects to login when the API returns 401.
@lazySingleton
class UnauthorizedLogoutHandler {
  UnauthorizedLogoutHandler(
    this._tokenProvider,
    this._firebaseMessagingService,
    @Named('googleAuth') this._googleAuth,
    @Named('appleAuth') this._appleAuth,
  );

  final TokenProviderService _tokenProvider;
  final FirebaseMessagingService _firebaseMessagingService;
  final AuthenticationService _googleAuth;
  final AuthenticationService _appleAuth;

  static const _excludedPaths = <String>[
    WebServiceConstant.authRegister,
  ];

  bool _isLoggingOut = false;

  Future<Result<NetworkFailure, HttpResponseEntity<dynamic>>> onError(
    NetworkFailure failure,
  ) async {
    if (failure is! UnauthorizedFailure) {
      return ResultExtension.failure(failure);
    }

    if (_shouldSkipLogout(failure)) {
      return ResultExtension.failure(failure);
    }

    await _forceLogout();
    return ResultExtension.failure(failure);
  }

  bool _shouldSkipLogout(UnauthorizedFailure failure) {
    final requestPath = _resolveRequestPath(failure);
    if (requestPath == null) {
      return false;
    }

    return _excludedPaths.any(requestPath.contains);
  }

  String? _resolveRequestPath(UnauthorizedFailure failure) {
    final details = failure.details;
    if (details == null) {
      return null;
    }

    try {
      final requestOptions = (details as dynamic).requestOptions;
      return requestOptions?.uri?.path as String?;
    } catch (_) {
      return null;
    }
  }

  Future<void> _forceLogout() async {
    if (_isLoggingOut) {
      return;
    }

    _isLoggingOut = true;
    try {
      final fcmResult = await _firebaseMessagingService.deleteToken();
      fcmResult.fold((_) {}, (_) {});

      final clearResult = await _tokenProvider.clearTokens();
      clearResult.fold((_) {}, (_) {});

      final googleSignOutResult = await _googleAuth.signOut();
      googleSignOutResult.fold((_) {}, (_) {});

      final appleSignOutResult = await _appleAuth.signOut();
      appleSignOutResult.fold((_) {}, (_) {});

      await StaticWidget.msgToast('Sesi berakhir, silakan login kembali');
      appRouter.go(RouteNames.login);
    } finally {
      _isLoggingOut = false;
    }
  }
}
