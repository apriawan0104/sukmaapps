import '../errors/authentication_failure.dart';
import '../errors/failures.dart';

/// Resolves user-facing messages from errors without any UI dependency.
///
/// Returns `null` when the error should not be shown to the user
/// (for example, when the user cancels authentication).
class FailureMessageResolver {
  const FailureMessageResolver._();

  static String? userMessage(Object error) {
    if (error is AuthenticationCancelledFailure) return null;
    if (error is Failure) return error.message;
    return error.toString();
  }

  static bool shouldNotifyUser(Object error) => userMessage(error) != null;
}
