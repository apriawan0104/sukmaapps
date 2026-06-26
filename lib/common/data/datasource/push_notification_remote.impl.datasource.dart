import 'dart:convert';

import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import 'push_notification_remote.datasource.dart';

@LazySingleton(as: PushNotificationRemoteDataSource)
class PushNotificationRemoteImplDataSource
    implements PushNotificationRemoteDataSource {
  PushNotificationRemoteImplDataSource(
    this._firebaseMessagingService,
    this._localNotificationService,
  );

  final FirebaseMessagingService _firebaseMessagingService;
  final LocalNotificationService _localNotificationService;

  @override
  Future<ValueGuard<void>> initialize({
    required OnForegroundNotificationCallback onForegroundNotification,
    required OnNotificationTappedCallback onNotificationTapped,
  }) async {
    final result = await _firebaseMessagingService.initialize(
      onForegroundNotification: onForegroundNotification,
      onNotificationTapped: onNotificationTapped,
    );

    return result.fold(
      (failure) => ValueGuards.failure(failure),
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<bool>> requestPermission() async {
    final result = await _firebaseMessagingService.requestPermission();
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<String>> getToken() async {
    final result = await _firebaseMessagingService.getToken();
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<void>> deleteToken() async {
    final result = await _firebaseMessagingService.deleteToken();
    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<NotificationDataEntity?>> getInitialNotification() async {
    final result = await _firebaseMessagingService.getInitialNotification();
    return result.fold(
      ValueGuards.failure,
      ValueGuards.success,
    );
  }

  @override
  Future<ValueGuard<void>> initializeLocalNotifications({
    required OnLocalNotificationTappedCallback onNotificationTapped,
  }) async {
    final result = await _localNotificationService.initialize(
      onNotificationTapped: onNotificationTapped,
      defaultAndroidIcon: SukmaNotificationConstant.androidIcon,
    );

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<void>> requestLocalPermission() async {
    final result = await _localNotificationService.requestPermission();
    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<void>> createDefaultChannel() async {
    final result = await _localNotificationService.createNotificationChannel(
      channelId: SukmaNotificationConstant.channelId,
      channelName: SukmaNotificationConstant.channelName,
      channelDescription: SukmaNotificationConstant.channelDescription,
      importance: NotificationImportance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      ledColor: SukmaNotificationConstant.androidAccentColor,
    );

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Future<ValueGuard<void>> showLocalNotification(
    NotificationDataEntity notification,
  ) async {
    final payload = notification.data == null
        ? null
        : json.encode(notification.data);

    final result = await _localNotificationService.show(
      NotificationConfig(
        id: notification.data?.hashCode ??
            DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: payload,
        channelId: SukmaNotificationConstant.channelId,
        channelName: SukmaNotificationConstant.channelName,
        channelDescription: SukmaNotificationConstant.channelDescription,
        importance: NotificationImportance.max,
        priority: NotificationPriority.max,
        playSound: true,
        ledColor: SukmaNotificationConstant.androidAccentColor,
        autoCancel: true,
      ),
    );

    return result.fold(
      ValueGuards.failure,
      (_) => ValueGuards.success(null),
    );
  }

  @override
  Stream<NotificationDataEntity> get onNotificationTap =>
      _firebaseMessagingService.onNotificationTap;

  @override
  Stream<NotificationDataEntity> get onLocalNotificationTap =>
      _localNotificationService.onNotificationTap;

  @override
  Stream<NotificationDataEntity> get onForegroundNotification =>
      _firebaseMessagingService.onForegroundNotification;

  @override
  Stream<String> get onTokenRefresh => _firebaseMessagingService.onTokenRefresh;
}
