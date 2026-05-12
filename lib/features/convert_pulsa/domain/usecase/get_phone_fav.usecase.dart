import 'package:app_core/app_core.dart';
import '../entity/entity.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetPhoneFavUseCase extends UseCaseAsync<List<PhoneFavEntity>, NoParams> {
  GetPhoneFavUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<List<PhoneFavEntity>>> call(NoParams params) async {
    return _repository.getListPhoneFav(params);
  }
}
