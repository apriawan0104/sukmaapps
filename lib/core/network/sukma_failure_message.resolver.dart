import 'package:app_core/app_core.dart';

import 'api_response.model.dart';

/// Resolves user-facing API error messages for Sukma.
///
/// Priority:
/// 1. `meta.error` from Sukma API envelope
/// 2. Default message from [app_core] failure types
class SukmaFailureMessageResolver {
  const SukmaFailureMessageResolver._();

  static String? userMessage(Object error) {
    if (error is AuthenticationCancelledFailure) return null;
    if (error is NetworkFailure) return _resolveNetworkMessage(error);
    if (error is Failure) return error.message;
    return error.toString();
  }

  static bool shouldNotifyUser(Object error) => userMessage(error) != null;

  static NetworkFailure mapFailure(NetworkFailure failure) {
    final message = _resolveNetworkMessage(failure);
    if (message == failure.message) return failure;

    return switch (failure) {
      UnauthorizedFailure() => UnauthorizedFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      ForbiddenFailure() => ForbiddenFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      NotFoundFailure() => NotFoundFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      ServerFailure(:final statusCode) => ServerFailure(
          message: message,
          statusCode: statusCode,
          code: failure.code,
          details: failure.details,
        ),
      ClientFailure(:final statusCode) => ClientFailure(
          message: message,
          statusCode: statusCode,
          code: failure.code,
          details: failure.details,
        ),
      ConnectionFailure() => ConnectionFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      TimeoutFailure() => TimeoutFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      CancelFailure() => CancelFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      ParseFailure() => ParseFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      UnknownNetworkFailure() => UnknownNetworkFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
      NetworkFailure() => NetworkFailure(
          message: message,
          code: failure.code,
          details: failure.details,
        ),
    };
  }

  static String _resolveNetworkMessage(NetworkFailure failure) {
    final apiError = _extractApiError(failure.details);
    if (apiError != null) return apiError;
    return _defaultNetworkMessage(failure);
  }

  static String? _extractApiError(dynamic data) {
    final error = ApiResponse.wrap(data).meta?.error;
    if (error == null) return null;

    final trimmed = error.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String _defaultNetworkMessage(NetworkFailure failure) {
    return switch (failure) {
      UnauthorizedFailure() => const UnauthorizedFailure().message,
      ForbiddenFailure() => const ForbiddenFailure().message,
      NotFoundFailure() => const NotFoundFailure().message,
      ServerFailure() => const ServerFailure().message,
      ClientFailure() => const ClientFailure().message,
      ConnectionFailure() => const ConnectionFailure().message,
      TimeoutFailure() => const TimeoutFailure().message,
      CancelFailure() => const CancelFailure().message,
      ParseFailure() => const ParseFailure().message,
      UnknownNetworkFailure() => const UnknownNetworkFailure().message,
      NetworkFailure() => failure.message,
    };
  }
}
