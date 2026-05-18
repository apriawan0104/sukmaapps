import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class ReadTermUseCase extends UseCaseAsync<void, NoParams> {
  ReadTermUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<ValueGuard<void>> call(NoParams params) async {
    return _repository.readTerm(params);
  }
}
