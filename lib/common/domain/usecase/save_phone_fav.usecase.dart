import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class SavePhoneFavUseCase extends UseCaseAsync<void, SavePhoneFavParam> {
  SavePhoneFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<void>> call(SavePhoneFavParam params) async {
    return _repository.savePhoneFav(params);
  }
}
