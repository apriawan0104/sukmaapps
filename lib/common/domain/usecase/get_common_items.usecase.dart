import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../repository/common.repository.dart';

class GetCommonItemsUseCase
    extends UseCaseAsync<List<CommonItemEntity>, NoParams> {
  GetCommonItemsUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<List<CommonItemEntity>>> call(NoParams params) {
    return _repository.getItems(params);
  }
}
