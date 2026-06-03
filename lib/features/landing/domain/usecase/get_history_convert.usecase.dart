import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../entity/entity.dart';
import '../repository/landing.repository.dart';

@lazySingleton
class GetHistoryConvertUseCase
    extends UseCaseAsync<List<HistoryConvertEntity>, NoParams> {
  GetHistoryConvertUseCase(this._repository);

  final LandingRepository _repository;

  @override
  Future<ValueGuard<List<HistoryConvertEntity>>> call(NoParams params) async {
    return _repository.getHistoryConvert(params);
  }
}
