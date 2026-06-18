import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

@lazySingleton
class TransEvidenceUseCase extends UseCaseAsync<void, TransEvidenceParam> {
  TransEvidenceUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(TransEvidenceParam params) async {
    return _repository.transEvidence(params);
  }
}
