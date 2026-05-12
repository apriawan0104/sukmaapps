import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/common.dart';
import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

@lazySingleton
class SaveTransKonfirmUseCase
    extends UseCaseAsync<TransferEntity, SaveTransKonfirmParam> {
  SaveTransKonfirmUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<TransferEntity>> call(SaveTransKonfirmParam params) async {
    return _repository.saveTransKonfirm(params);
  }
}
