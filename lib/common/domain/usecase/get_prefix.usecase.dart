import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../param/param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetPrefixUseCase extends UseCaseAsync<PrefixEntity, GetPrefixParam> {
  GetPrefixUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<PrefixEntity>> call(GetPrefixParam params) async {
    return _repository.getPrefix(params);
  }
}
