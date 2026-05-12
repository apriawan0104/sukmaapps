import 'package:app_core/app_core.dart';
import '../param/param.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class SavePhoneFavUseCase extends UseCaseAsync<void, SavePhoneFavParam> {
  SavePhoneFavUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<void>> call(SavePhoneFavParam params) async {
    return _repository.savePhoneFav(params);
  }
}
