import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../param/get_detail_transaction.param.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetDetailTransactionUseCase
    extends UseCaseAsync<TransferEntity?, GetDetailTransactionParam> {
  GetDetailTransactionUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<TransferEntity?>> call(
    GetDetailTransactionParam params,
  ) async {
    return _repository.getDetailTransaction(params);
  }
}
