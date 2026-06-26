import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/push_notification.repository.dart';
import '../datasource/push_notification_local.datasource.dart';
import '../datasource/push_notification_remote.datasource.dart';

@LazySingleton(as: PushNotificationRepository)
class PushNotificationImplRepository implements PushNotificationRepository {
  PushNotificationImplRepository(
    this._remoteDataSource,
    this._localDataSource,
  );

  final PushNotificationRemoteDataSource _remoteDataSource;
  final PushNotificationLocalDataSource _localDataSource;

  @override
  Future<ValueGuard<void>> initialize() async {
    final localInitResult = await _remoteDataSource.initializeLocalNotifications(
      onNotificationTapped: (_) async {},
    );
    if (localInitResult.isLeft()) {
      return localInitResult;
    }

    final channelResult = await _remoteDataSource.createDefaultChannel();
    if (channelResult.isLeft()) {
      return channelResult;
    }

    final localPermissionResult =
        await _remoteDataSource.requestLocalPermission();
    if (localPermissionResult.isLeft()) {
      return localPermissionResult;
    }

    final fcmInitResult = await _remoteDataSource.initialize(
      onForegroundNotification: _showForegroundNotification,
      onNotificationTapped: (_) async {},
    );
    if (fcmInitResult.isLeft()) {
      return fcmInitResult;
    }

    final permissionResult = await _remoteDataSource.requestPermission();
    permissionResult.fold((_) {}, (_) {});

    final syncResult = await syncFcmToken();
    if (syncResult.isLeft()) {
      return syncResult;
    }

    return ValueGuards.success(null);
  }

  Future<void> _showForegroundNotification(
    NotificationDataEntity notification,
  ) async {
    await _remoteDataSource.showLocalNotification(notification);
  }

  @override
  Future<ValueGuard<void>> syncFcmToken() async {
    final tokenResult = await _remoteDataSource.getToken();
    return tokenResult.flatMapAsync((token) async {
      return _localDataSource.saveFcmToken(token);
    });
  }

  @override
  Future<ValueGuard<void>> removeFcmToken() async {
    final deleteResult = await _remoteDataSource.deleteToken();
    deleteResult.fold((_) {}, (_) {});

    return _localDataSource.removeFcmToken();
  }

  @override
  Future<ValueGuard<bool>> hasActiveSession() async {
    final userIdResult = await _localDataSource.getUserId();
    final tokenResult = await _localDataSource.getToken();

    return userIdResult.flatMapAsync((userId) async {
      return tokenResult.mapValue((token) {
        return userId != null &&
            userId.isNotEmpty &&
            token != null &&
            token.isNotEmpty;
      });
    });
  }

  @override
  Future<ValueGuard<NotificationDataEntity?>> getInitialNotification() {
    return _remoteDataSource.getInitialNotification();
  }

  @override
  Stream<NotificationDataEntity> get onNotificationTap =>
      _remoteDataSource.onNotificationTap;

  @override
  Stream<NotificationDataEntity> get onLocalNotificationTap =>
      _remoteDataSource.onLocalNotificationTap;

  @override
  Stream<NotificationDataEntity> get onForegroundNotification =>
      _remoteDataSource.onForegroundNotification;

  @override
  Stream<String> get onTokenRefresh => _remoteDataSource.onTokenRefresh;
}
