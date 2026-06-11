import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class LogoutUseCase extends UseCaseAsync<void, NoParams> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<ValueGuard<void>> call(NoParams params) async {
    return _repository.logout(params);
  }
}
