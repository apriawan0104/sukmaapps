import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class CheckStatusAppUseCase extends UseCaseAsync<StatusAppEntity, NoParams> {
  CheckStatusAppUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<StatusAppEntity>> call(NoParams params) async {
    return _repository.checkStatusApp(params);
  }
}
