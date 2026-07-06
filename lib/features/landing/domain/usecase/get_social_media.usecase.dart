import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetSocialMediaUseCase
    extends UseCaseAsync<List<SocialMediaEntity>, NoParams> {
  GetSocialMediaUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<SocialMediaEntity>>> call(NoParams params) async {
    return _repository.getSocialMedia(params);
  }
}
