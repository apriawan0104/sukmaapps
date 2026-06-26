import 'dart:convert';
import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sukmaapps/core/core.dart';

import '../../domain/entity/app_version_check.entity.dart';
import '../../domain/repository/version_update.repository.dart';
import '../model/app_version_config.model.dart';

@LazySingleton(as: VersionUpdateRepository)
class VersionUpdateImplRepository implements VersionUpdateRepository {
  VersionUpdateImplRepository(this._remoteConfigService);

  final RemoteConfigService _remoteConfigService;

  @override
  Future<ValueGuard<void>> initializeRemoteConfig() async {
    final result = await _remoteConfigService.initialize();
    return result.fold(
      (failure) => ValueGuards.failure(
        Failure(message: failure.message, code: failure.code),
      ),
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<AppVersionCheckEntity>> checkAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      final configResult = await _remoteConfigService.getString(
        VersionUpdateConstant.latestAppVersionsKey,
      );

      return configResult.flatMapAsync((configStr) async {
        if (configStr.isEmpty) {
          return ValueGuards.success(AppVersionCheckEntity.none);
        }

        final configJson = json.decode(configStr) as Map<String, dynamic>;
        final versionConfig = AppVersionConfigModel.fromJson(configJson);
        final platformConfig =
            Platform.isAndroid ? versionConfig.android : versionConfig.ios;

        if (platformConfig.versionCode <= currentVersionCode) {
          return ValueGuards.success(AppVersionCheckEntity.none);
        }

        final versionGap = platformConfig.versionCode - currentVersionCode;
        final isForceUpdate = versionGap >= 2 ||
            (platformConfig.isForced &&
                currentVersionCode < platformConfig.versionCode);

        return ValueGuards.success(
          AppVersionCheckEntity(
            needsUpdate: true,
            isForceUpdate: isForceUpdate,
          ),
        );
      });
    } catch (_) {
      return ValueGuards.success(AppVersionCheckEntity.none);
    }
  }
}
