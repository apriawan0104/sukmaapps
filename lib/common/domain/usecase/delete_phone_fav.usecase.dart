import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class DeletePhoneFavUseCase extends UseCaseAsync<void, DeletePhoneFavParam> {
  DeletePhoneFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<void>> call(DeletePhoneFavParam params) async {
    return _repository.deletePhoneFav(params);
  }
}
