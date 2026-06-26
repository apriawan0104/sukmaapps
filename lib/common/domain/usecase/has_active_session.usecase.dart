import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../repository/push_notification.repository.dart';

@lazySingleton
class HasActiveSessionUseCase extends UseCaseAsync<bool, NoParams> {
  HasActiveSessionUseCase(this._repository);

  final PushNotificationRepository _repository;

  @override
  Future<ValueGuard<bool>> call(NoParams params) {
    return _repository.hasActiveSession();
  }
}
