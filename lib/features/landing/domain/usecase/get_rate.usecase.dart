import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetRateUseCase extends UseCaseAsync<List<RateEntity>, NoParams> {
  GetRateUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<RateEntity>>> call(NoParams params) async {
    return _repository.getRate(params);
  }
}
