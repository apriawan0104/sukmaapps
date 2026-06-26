import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
import '../../domain/usecase/init_push_notification.usecase.dart';
import '../../domain/usecase/sync_fcm_token.usecase.dart';
import '../handler/notification_route.handler.dart';
import '../handler/push_notification_refresh.handler.dart';
import '../../domain/repository/push_notification.repository.dart';

part 'push_notification.service.g.dart';

@Riverpod(keepAlive: true)
class PushNotification extends _$PushNotification {
  late InitPushNotificationUseCase _initPushNotificationUseCase;
  late SyncFcmTokenUseCase _syncFcmTokenUseCase;
  late PushNotificationRepository _repository;

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @override
  Future<void> build() async {
    _initPushNotificationUseCase = getIt<InitPushNotificationUseCase>();
    _syncFcmTokenUseCase = getIt<SyncFcmTokenUseCase>();
    _repository = getIt<PushNotificationRepository>();

    ref.onDispose(_disposeSubscriptions);

    await _initialize();
  }

  Future<void> _initialize() async {
    final initResult = await _initPushNotificationUseCase(NoParams());
    initResult.fold(
      (failure) {
        if (kDebugMode) {
          print('Push notification init failed: ${failure.message}');
        }
      },
      (_) {},
    );

    _subscriptions
      ..add(
        _repository.onForegroundNotification.listen(
          (_) => refreshDataAfterNotificationOpened(ref),
        ),
      )
      ..add(
        _repository.onNotificationTap.listen(_handleNotificationOpened),
      )
      ..add(
        _repository.onLocalNotificationTap.listen(_handleNotificationOpened),
      )
      ..add(
        _repository.onTokenRefresh.listen((_) => syncToken()),
      );

    await _handleColdStartNotification();
  }

  Future<void> _handleColdStartNotification() async {
    final initialResult = await _repository.getInitialNotification();
    initialResult.fold(
      (_) {},
      (notification) async {
        if (notification == null) {
          await refreshDataAfterNotificationOpened(ref);
          return;
        }

        await refreshDataAfterNotificationOpened(ref);
        navigateFromNotification(notification);
      },
    );
  }

  Future<void> _handleNotificationOpened(
    NotificationDataEntity notification,
  ) async {
    await refreshDataAfterNotificationOpened(ref);
    navigateFromNotification(notification);
  }

  Future<void> syncToken() async {
    final result = await _syncFcmTokenUseCase(NoParams());
    result.fold(
      (_) {},
      (_) {
        if (kDebugMode) {
          print('FCM token synced');
        }
      },
    );
  }

  void _disposeSubscriptions() {
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    _subscriptions.clear();
  }
}
