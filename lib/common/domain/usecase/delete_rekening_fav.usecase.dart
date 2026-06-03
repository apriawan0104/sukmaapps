import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class DeleteRekeningFavUseCase
    extends UseCaseAsync<void, DeleteRekeningFavParam> {
  DeleteRekeningFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<void>> call(DeleteRekeningFavParam params) async {
    return _repository.deleteRekeningFav(params);
  }
}
