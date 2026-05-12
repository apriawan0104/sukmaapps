import 'package:app_core/app_core.dart';
import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class SaveRekeningFavUseCase extends UseCaseAsync<void, SaveRekeningFavParam> {
  SaveRekeningFavUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(SaveRekeningFavParam params) async {
    return _repository.saveRekeningFav(params);
  }
}
