import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetPhoneFavUseCase extends UseCaseAsync<List<PhoneFavEntity>, NoParams> {
  GetPhoneFavUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<List<PhoneFavEntity>>> call(NoParams params) async {
    return _repository.getListPhoneFav(params);
  }
}
