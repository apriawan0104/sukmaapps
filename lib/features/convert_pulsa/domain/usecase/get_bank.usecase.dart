import 'package:app_core/app_core.dart';
import '../entity/entity.dart';
import '../repository/convert_pulsa.repository.dart';

/// Template: VS Code snippet `uscs` (prefix `uscs`) — satu use case per file jika mau lebih rapi.
class GetBankUseCase extends UseCaseAsync<List<BankEntity>, NoParams> {
  GetBankUseCase(this._repository);

  final ConvertPulsaRepository _repository;

  @override
  Future<ValueGuard<List<BankEntity>>> call(NoParams params) async {
    return _repository.getListBank(params);
  }
}
