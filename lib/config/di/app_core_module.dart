import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';

/// Registers shared infrastructure from [app_core].
///
/// Host app owns the DI graph; this module only wires core contracts to
/// default implementations.
@module
abstract class AppCoreModule {
  @lazySingleton
  BackgroundService get backgroundService =>
      FlutterBackgroundServiceImpl.instance();

  @lazySingleton
  SecureStorageService get secureStorageService =>
      FlutterSecureStorageServiceImpl();

  @lazySingleton
  StorageService get storageService => HiveStorageServiceImpl();

  @lazySingleton
  LogService get logService => const ConsoleLogServiceImpl();

  @lazySingleton
  UrlLauncherService get urlLauncherService => UrlLauncherServiceImpl();

  @lazySingleton
  ResponsiveService get responsiveService => ResponsiveServiceImpl();

  @lazySingleton
  RepositoryErrorHandler get repositoryErrorHandler =>
      RepositoryErrorHandler(null);

  @lazySingleton
  LocalNotificationService get localNotificationService =>
      LocalNotificationServiceImpl();

  @lazySingleton
  FirebaseMessagingService get firebaseMessagingService =>
      FirebaseMessagingServiceImpl();

  @lazySingleton
  HttpClient httpClient(
    NetworkConfig config,
    TokenProviderService tokenProvider,
  ) {
    final client = DioHttpClient(
      baseUrl: config.baseUrl,
      headers: config.headers,
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      sendTimeout: config.sendTimeout,
      enableLogging: config.enableLogging,
      dioInterceptors: config.dioInterceptors,
    );

    final authInterceptor = AuthInterceptor(
      tokenProvider: tokenProvider,
      excludedPaths: [
        WebServiceConstant.authRegister,
      ],
    );
    client.addRequestInterceptor(authInterceptor.onRequest);

    return client;
  }
}
