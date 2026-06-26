import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class NotificationOpenedRefresher {
  Future<void> refresh(Ref ref);
}
