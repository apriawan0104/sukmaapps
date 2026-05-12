import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetInformationBannerUseCase
    extends UseCaseAsync<List<InformationBannerEntity>, NoParams> {
  GetInformationBannerUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<InformationBannerEntity>>> call(
      NoParams params) async {
    return _repository.getInformationBanner(params);
  }
}
