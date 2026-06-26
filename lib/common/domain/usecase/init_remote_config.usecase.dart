import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../repository/version_update.repository.dart';

@lazySingleton
class InitRemoteConfigUseCase extends UseCaseAsync<void, NoParams> {
  InitRemoteConfigUseCase(this._repository);

  final VersionUpdateRepository _repository;

  @override
  Future<ValueGuard<void>> call(NoParams params) {
    return _repository.initializeRemoteConfig();
  }
}
