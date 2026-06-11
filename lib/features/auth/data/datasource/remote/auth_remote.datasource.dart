import 'package:app_core/app_core.dart';

import '../../../domain/domain.dart';

abstract class AuthRemoteDataSource {
  Future<ValueGuard<void>> loginGoogle(NoParams params);
  Future<ValueGuard<void>> loginApple(NoParams params);
  Future<ValueGuard<void>> readTerm(NoParams params);
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params);
  Future<ValueGuard<void>> logout(NoParams params);
}
