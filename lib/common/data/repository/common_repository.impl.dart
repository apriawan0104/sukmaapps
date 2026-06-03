import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/entity.dart';
import '../../domain/param/param.dart';
import '../../domain/repository/common.repository.dart';
import '../datasource/common_remote.datasource.dart';
import '../model/model.dart';

@LazySingleton(as: CommonRepository)
class CommonImplRepository implements CommonRepository {
  CommonImplRepository(this._remoteDataSource);

  final CommonRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<String>> getWaNumber(NoParams params) async {
    final result = await _remoteDataSource.getWaNumber(params);
    return result.mapValue((model) => model);
  }

  @override
  Future<ValueGuard<List<PhoneFavEntity>>> getListPhoneFav(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListPhoneFav(params);
    return result.mapListValue(
      (PhoneFavModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  ) async {
    await _remoteDataSource.deletePhoneFav(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<List<RekeningFavEntity>>> getListRekeningFav(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListRekeningFav(params);
    return result.mapListValue(
      (RekeningFavModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  ) async {
    await _remoteDataSource.deleteRekeningFav(params);
    return ValueGuards.success(null);
  }
}
