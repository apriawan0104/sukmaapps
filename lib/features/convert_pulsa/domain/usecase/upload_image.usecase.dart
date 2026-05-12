import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

@lazySingleton
class UploadImageUseCase extends UseCaseAsync<void, UploadImageParam> {
  UploadImageUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(UploadImageParam params) async {
    return _repository.uploadImage(params);
  }
}
