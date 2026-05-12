import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

@lazySingleton
class DeleteImageUseCase extends UseCaseAsync<void, DeleteImageParam> {
  DeleteImageUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(DeleteImageParam params) async {
    return _repository.deleteImage(params);
  }
}
