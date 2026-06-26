import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetOutstandingUseCase extends UseCaseAsync<TransferEntity?, NoParams> {
  GetOutstandingUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<TransferEntity?>> call(NoParams params) async {
    return _repository.getOutstanding(params);
  }
}
