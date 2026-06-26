import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/common/common.dart';

import '../adapter/landing.adapter.dart';

@LazySingleton(as: NotificationOpenedRefresher)
class LandingNotificationOpenedRefresher
    implements NotificationOpenedRefresher {
  @override
  Future<void> refresh(Ref ref) async {
    if (ref.exists(landingRiverpodAdapterProvider)) {
      await ref.read(landingRiverpodAdapterProvider.notifier).getHistoryConvert();
    }
  }
}
