import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../repository/common.repository.dart';

@lazySingleton
class GetWaNumberUseCase extends UseCaseAsync<String, NoParams> {
  GetWaNumberUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<String>> call(NoParams params) async {
    return _repository.getWaNumber(params);
  }
}
