import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../repository/push_notification.repository.dart';

@lazySingleton
class SyncFcmTokenUseCase extends UseCaseAsync<void, NoParams> {
  SyncFcmTokenUseCase(this._repository);

  final PushNotificationRepository _repository;

  @override
  Future<ValueGuard<void>> call(NoParams params) {
    return _repository.syncFcmToken();
  }
}
