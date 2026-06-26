import 'package:app_core/app_core.dart';

import '../entity/app_version_check.entity.dart';

abstract class VersionUpdateRepository {
  Future<ValueGuard<void>> initializeRemoteConfig();

  Future<ValueGuard<AppVersionCheckEntity>> checkAppVersion();
}
