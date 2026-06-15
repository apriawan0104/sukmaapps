import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../entity/entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class LoginAppleUseCase extends UseCaseAsync<UserEntity, NoParams> {
  LoginAppleUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<ValueGuard<UserEntity>> call(NoParams params) async {
    return _repository.loginApple(params);
  }
}
