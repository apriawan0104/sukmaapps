import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/common.repository.dart';
import '../datasource/common_remote.datasource.dart';

@LazySingleton(as: CommonRepository)
class CommonImplRepository implements CommonRepository {
  CommonImplRepository(this._remoteDataSource);

  final CommonRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<String>> getWaNumber(NoParams params) async {
    final result = await _remoteDataSource.getWaNumber(params);
    return result.mapValue((model) => model);
  }
}
