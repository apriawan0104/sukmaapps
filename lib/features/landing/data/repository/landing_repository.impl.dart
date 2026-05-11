import 'package:app_core/app_core.dart';

import '../../domain/entity/entity.dart';
import '../../domain/param/param.dart';
import '../../domain/repository/landing.repository.dart';
import '../datasource/landing_remote.datasource.dart';
import '../model/model.dart';

/// Template: VS Code snippet `reimp` (prefix `reimp`).
class LandingImplRepository implements LandingRepository {
  LandingImplRepository(this._remoteDataSource);

  final LandingRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<List<LandingItemEntity>>> getListLandingItems(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListLandingItems(params);
    return result.mapListValue(
      (LandingItemModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<LandingItemEntity>> getLandingItem(
    GetLandingItemParams params,
  ) async {
    final result = await _remoteDataSource.getLandingItem(params);
    return result.mapValue(
      (LandingItemModel item) => item.toEntity(),
    );
  }
}
