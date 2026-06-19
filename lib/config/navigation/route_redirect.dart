import 'dart:async';

import 'package:go_router/go_router.dart';

import '../di/locator.dart';
import '../../features/auth/data/datasource/local/auth_local.datasource.dart';
import 'route_names.dart';

const _publicRoutePaths = <String>{
  RouteNames.login,
  '/privacy-policy',
  '/term-condition',
  RouteNames.forceUpdate,
};

bool _isFilled(String? value) {
  return value != null && value.trim().isNotEmpty;
}

/// Validates whether the user has an active local session.
///
/// Extend this method when additional session checks are required.
Future<bool> isSessionValid() async {
  final authLocal = getIt<AuthLocalDataSource>();

  final userId = (await authLocal.getUserId()).fold(
    (_) => null,
    (value) => value,
  );
  final token = (await authLocal.getToken()).fold(
    (_) => null,
    (value) => value,
  );

  return _isFilled(userId) && _isFilled(token);
}

bool isPublicRoute(String location) {
  return _publicRoutePaths.contains(location);
}

FutureOr<String?> resolveAuthRedirect(GoRouterState state) async {
  final location = state.matchedLocation;
  final isAuthenticated = await isSessionValid();

  if (isAuthenticated) {
    if (location == RouteNames.login) {
      return RouteNames.landing;
    }
    return null;
  }

  if (!isPublicRoute(location)) {
    return RouteNames.login;
  }

  return null;
}
