import 'package:app_core/app_core.dart';

import '../../domain/entity/entity.dart';
import '../../domain/repository/common.repository.dart';
import '../datasource/common_remote.datasource.dart';
import '../model/model.dart';

class CommonImplRepository implements CommonRepository {
  CommonImplRepository(this._remoteDataSource);

  final CommonRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<List<CommonItemEntity>>> getItems(NoParams params) async {
    final result = await _remoteDataSource.getItems(params);
    return result.mapListValue(
      (CommonItemModel item) => item.toEntity(),
    );
  }
}
