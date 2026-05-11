import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetListConvertPulsaItemsUseCase
    extends UseCaseAsync<List<ConvertPulsaItemEntity>, NoParams> {
  GetListConvertPulsaItemsUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<List<ConvertPulsaItemEntity>>> call(NoParams params) {
    return _repository.getListConvertPulsaItems(params);
  }
}

class GetConvertPulsaItemUseCase
    extends UseCaseAsync<ConvertPulsaItemEntity, GetConvertPulsaItemParams> {
  GetConvertPulsaItemUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<ConvertPulsaItemEntity>> call(
    GetConvertPulsaItemParams params,
  ) {
    return _repository.getConvertPulsaItem(params);
  }
}
