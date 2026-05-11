import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';
import '../repository/landing.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetListLandingItemsUseCase
    extends UseCaseAsync<List<LandingItemEntity>, NoParams> {
  GetListLandingItemsUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<LandingItemEntity>>> call(NoParams params) {
    return _repository.getListLandingItems(params);
  }
}

class GetLandingItemUseCase
    extends UseCaseAsync<LandingItemEntity, GetLandingItemParams> {
  GetLandingItemUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<LandingItemEntity>> call(GetLandingItemParams params) {
    return _repository.getLandingItem(params);
  }
}
