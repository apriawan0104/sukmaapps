import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../entity/entity.dart';
import '../repository/common.repository.dart';

@lazySingleton
class GetStatusTransaksiFailedUseCase
    extends UseCaseAsync<List<StatusTransaksiEntity>, NoParams> {
  GetStatusTransaksiFailedUseCase(this._repository);

  final CommonRepository _repository;

  @override
  Future<ValueGuard<List<StatusTransaksiEntity>>> call(NoParams params) async {
    return _repository.getStatusTransaksiFailed(params);
  }
}
