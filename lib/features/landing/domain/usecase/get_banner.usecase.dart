import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../param/param.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetBannerUseCase extends UseCaseAsync<List<BannerEntity>, NoParams> {
  GetBannerUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<BannerEntity>>> call(NoParams params) async {
    return _repository.getBanner(params);
  }
}
