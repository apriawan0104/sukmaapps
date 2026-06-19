import 'package:app_core/app_core.dart';

import '../../../domain/domain.dart';
import '../../model/model.dart';

abstract class AuthRemoteDataSource {
  Future<ValueGuard<AuthCredentials>> signInWithGoogle(NoParams params);
  Future<ValueGuard<AuthCredentials>> signInWithApple(NoParams params);
  Future<ValueGuard<UserModel>> register(RegisterParam params);
  Future<ValueGuard<void>> readTerm(ReadTermParam params);
  Future<ValueGuard<void>> deleteAccount(DeleteAccountParams params);
}
