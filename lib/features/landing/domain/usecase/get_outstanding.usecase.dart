import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/common.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetOutstandingUseCase
    extends UseCaseAsync<List<TransferEntity>, NoParams> {
  GetOutstandingUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<TransferEntity>>> call(NoParams params) async {
    return _repository.getOutstanding(params);
  }
}
