import 'package:app_core/app_core.dart';

abstract class AuthRemoteDataSource {
  Future<ValueGuard<void>> loginGoogle(NoParams params);
  Future<ValueGuard<void>> loginApple(NoParams params);
  Future<ValueGuard<void>> readTerm(NoParams params);
}
