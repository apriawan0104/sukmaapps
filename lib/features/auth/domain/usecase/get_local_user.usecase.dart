import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class GetLocalUserUseCase extends UseCaseAsync<LocalUserEntity, NoParams> {
  GetLocalUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<ValueGuard<LocalUserEntity>> call(NoParams params) async {
    return _repository.getLocalUser(params);
  }
}
