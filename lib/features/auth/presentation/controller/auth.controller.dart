library;

// Coordinates login screen flow and calls domain (Notifier / Bloc / Cubit, etc.).
abstract class AuthController {
  Future<void> loginWithGoogle();
  Future<void> loginWithApple();
  Future<void> readTerm();
}
