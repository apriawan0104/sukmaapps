// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_core/src/configuration/di/app_core_module.dart' as _i512;
import 'package:app_core/src/helpers/repository_error_handler.dart' as _i158;
import 'package:app_core/src/infrastructure/analytics/contract/crash_reporter.service.dart'
    as _i117;
import 'package:app_core/src/infrastructure/background_service/background_service.dart'
    as _i567;
import 'package:app_core/src/infrastructure/logging/logging.dart' as _i665;
import 'package:app_core/src/infrastructure/network/network.dart' as _i944;
import 'package:app_core/src/infrastructure/notification/contract/notification.dart'
    as _i386;
import 'package:app_core/src/infrastructure/notification/impl/firebase_messaging.service.impl.dart'
    as _i1038;
import 'package:app_core/src/infrastructure/notification/impl/local_notification.service.impl.dart'
    as _i835;
import 'package:app_core/src/infrastructure/responsive/contract/contracts.dart'
    as _i297;
import 'package:app_core/src/infrastructure/responsive/impl/responsive.service.impl.dart'
    as _i969;
import 'package:app_core/src/infrastructure/secure_storage/secure_storage.dart'
    as _i666;
import 'package:app_core/src/infrastructure/storage/storage.dart' as _i1014;
import 'package:app_core/src/infrastructure/url_launcher/url_launcher.dart'
    as _i2;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initBumaCore({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appCoreModule = _$AppCoreModule();
    gh.lazySingleton<_i892.FirebaseMessaging>(
        () => appCoreModule.firebaseMessaging);
    gh.lazySingleton<_i163.FlutterLocalNotificationsPlugin>(
        () => appCoreModule.flutterLocalNotificationsPlugin);
    gh.lazySingleton<_i567.BackgroundService>(
        () => appCoreModule.backgroundService);
    gh.lazySingleton<_i666.SecureStorageService>(
        () => appCoreModule.secureStorageService);
    gh.lazySingleton<_i1014.StorageService>(() => appCoreModule.storageService);
    gh.lazySingleton<_i665.LogService>(() => appCoreModule.logService);
    gh.lazySingleton<_i2.UrlLauncherService>(
        () => appCoreModule.urlLauncherService);
    gh.lazySingleton<_i297.ResponsiveService>(
        () => _i969.ResponsiveServiceImpl());
    gh.lazySingleton<_i158.RepositoryErrorHandler>(
        () => _i158.RepositoryErrorHandler(gh<_i117.CrashReporterService>()));
    gh.lazySingleton<_i386.LocalNotificationService>(() =>
        _i835.LocalNotificationServiceImpl(
            localNotifications: gh<_i163.FlutterLocalNotificationsPlugin>()));
    gh.lazySingleton<_i944.HttpClient>(
        () => appCoreModule.httpClient(gh<_i944.NetworkConfig>()));
    gh.lazySingleton<_i386.FirebaseMessagingService>(() =>
        _i1038.FirebaseMessagingServiceImpl(
            firebaseMessaging: gh<_i892.FirebaseMessaging>()));
    return this;
  }
}

class _$AppCoreModule extends _i512.AppCoreModule {}
