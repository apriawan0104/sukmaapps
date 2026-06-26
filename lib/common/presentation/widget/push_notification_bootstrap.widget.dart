import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/push_notification.service.dart';

/// Ensures push notification listeners are active for the app lifetime.
class PushNotificationBootstrap extends ConsumerWidget {
  const PushNotificationBootstrap({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pushNotificationProvider);
    return child;
  }
}
