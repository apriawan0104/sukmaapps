import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/app_version_check.entity.dart';
import '../repository/version_update.repository.dart';

@lazySingleton
class CheckAppVersionUseCase
    extends UseCaseAsync<AppVersionCheckEntity, NoParams> {
  CheckAppVersionUseCase(this._repository);

  final VersionUpdateRepository _repository;

  @override
  Future<ValueGuard<AppVersionCheckEntity>> call(NoParams params) {
    return _repository.checkAppVersion();
  }
}
