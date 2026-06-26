import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:dartz/dartz.dart';

/// No-op FCM implementation for web (Firebase is not initialized on web).
class FirebaseMessagingNoopService implements FirebaseMessagingService {
  const FirebaseMessagingNoopService();

  static final _emptyNotificationStream =
      Stream<NotificationDataEntity>.empty();

  @override
  Future<Either<NotificationFailure, void>> initialize({
    OnNotificationTappedCallback? onNotificationTapped,
    OnForegroundNotificationCallback? onForegroundNotification,
    OnBackgroundNotificationCallback? onBackgroundNotification,
    bool autoInitEnabled = true,
  }) async {
    return const Right(null);
  }

  @override
  Future<Either<NotificationFailure, bool>> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    return const Right(false);
  }

  @override
  Future<Either<NotificationFailure, String>> getToken() async {
    return const Right('');
  }

  @override
  Future<Either<NotificationFailure, void>> deleteToken() async {
    return const Right(null);
  }

  @override
  Future<Either<NotificationFailure, void>> subscribeToTopic(String topic) async {
    return const Right(null);
  }

  @override
  Future<Either<NotificationFailure, void>> unsubscribeFromTopic(
    String topic,
  ) async {
    return const Right(null);
  }

  @override
  Future<Either<NotificationFailure, NotificationDataEntity?>>
      getInitialNotification() async {
    return const Right(null);
  }

  @override
  Stream<String> get onTokenRefresh => const Stream.empty();

  @override
  Stream<NotificationDataEntity> get onNotificationTap =>
      _emptyNotificationStream;

  @override
  Stream<NotificationDataEntity> get onForegroundNotification =>
      _emptyNotificationStream;

  @override
  bool get isSupported => false;

  @override
  Future<Either<NotificationFailure, void>> setAutoInitEnabled(
    bool enabled,
  ) async {
    return const Right(null);
  }

  @override
  bool isAutoInitEnabled() => false;

  @override
  Future<Either<NotificationFailure, void>> setDeliveryMetricsExportToBigQuery(
    bool enabled,
  ) async {
    return const Right(null);
  }
}

/// No-op Remote Config implementation for web (Firebase is not initialized on web).
class RemoteConfigNoopService implements RemoteConfigService {
  const RemoteConfigNoopService({required RemoteConfigConfig config})
      : _config = config;

  final RemoteConfigConfig _config;

  @override
  Future<Either<RemoteConfigFailure, void>> initialize() async {
    return const Right(null);
  }

  @override
  Future<Either<RemoteConfigFailure, void>> fetchAndActivate() async {
    return const Right(null);
  }

  @override
  Future<Either<RemoteConfigFailure, String>> getString(String key) async {
    final value = _config.defaults[key];
    if (value is String) {
      return Right(value);
    }
    return const Right('');
  }

  @override
  Future<Either<RemoteConfigFailure, bool>> getBool(String key) async {
    final value = _config.defaults[key];
    if (value is bool) {
      return Right(value);
    }
    return const Right(false);
  }

  @override
  Future<Either<RemoteConfigFailure, int>> getInt(String key) async {
    final value = _config.defaults[key];
    if (value is int) {
      return Right(value);
    }
    return const Right(0);
  }

  @override
  Future<Either<RemoteConfigFailure, double>> getDouble(String key) async {
    final value = _config.defaults[key];
    if (value is double) {
      return Right(value);
    }
    return const Right(0);
  }
}
