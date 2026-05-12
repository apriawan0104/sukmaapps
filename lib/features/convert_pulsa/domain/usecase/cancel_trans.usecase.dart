import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

@lazySingleton
class CancelTransUseCase extends UseCaseAsync<void, CancelParam> {
  CancelTransUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(CancelParam params) async {
    return _repository.cancelTrans(params);
  }
}
