import 'package:app_core/app_core.dart';
import '../entity/entity.dart';
import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetPrefixUseCase extends UseCaseAsync<PrefixEntity, GetPrefixParam> {
  GetPrefixUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<PrefixEntity>> call(GetPrefixParam params) {
    return _repository.getPrefix(params);
  }
}
