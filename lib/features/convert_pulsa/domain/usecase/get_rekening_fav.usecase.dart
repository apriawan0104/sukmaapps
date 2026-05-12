import 'package:app_core/app_core.dart';
import '../entity/entity.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetRekeningFavUseCase
    extends UseCaseAsync<List<RekeningFavEntity>, NoParams> {
  GetRekeningFavUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<List<RekeningFavEntity>>> call(NoParams params) async {
    return _repository.getListRekeningFav(params);
  }
}
