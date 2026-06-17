import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class SaveRekeningFavUseCase extends UseCaseAsync<void, SaveRekeningFavParam> {
  SaveRekeningFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<void>> call(SaveRekeningFavParam params) async {
    return _repository.saveRekeningFav(params);
  }
}
