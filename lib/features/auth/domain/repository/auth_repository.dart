import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';

abstract class AuthRepository {
  Future<ValueGuard<UserEntity>> loginGoogle(NoParams params);
  Future<ValueGuard<UserEntity>> loginApple(NoParams params);
  Future<ValueGuard<UserEntity>> refreshToken(NoParams params);
  Future<ValueGuard<void>> readTerm(NoParams params);
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params);
  Future<ValueGuard<void>> logout(NoParams params);
  Future<ValueGuard<LocalUserEntity>> getLocalUser(NoParams params);
}
