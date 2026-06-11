import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../param/param.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class DeleteAccountUseCase extends UseCaseAsync<void, DeleteAccountParams> {
  DeleteAccountUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<ValueGuard<void>> call(DeleteAccountParams params) async {
    return _repository.deleteAccount(params);
  }
}
