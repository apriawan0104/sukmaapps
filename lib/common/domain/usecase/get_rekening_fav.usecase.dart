import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetRekeningFavUseCase
    extends UseCaseAsync<List<RekeningFavEntity>, NoParams> {
  GetRekeningFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<List<RekeningFavEntity>>> call(NoParams params) async {
    return _repository.getListRekeningFav(params);
  }
}
