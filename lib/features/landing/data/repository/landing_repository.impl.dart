import 'package:app_core/app_core.dart';

import '../../domain/entity/entity.dart';
import '../../domain/repository/landing.repository.dart';
import '../datasource/landing_remote.datasource.dart';
import '../model/model.dart';

/// Template: VS Code snippet `reimp` (prefix `reimp`).
class LandingImplRepository implements LandingRepository {
  LandingImplRepository(this._remoteDataSource);

  final LandingRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<List<BannerEntity>>> getBanner(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getBanner(params);
    return result.mapListValue(
      (BannerModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<List<InformationBannerEntity>>> getInformationBanner(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getInformationBanner(params);
    return result.mapListValue(
      (InformationBannerModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<List<RateEntity>>> getRate(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getRate(params);
    return result.mapListValue(
      (RateModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<StatusAppEntity>> checkStatusApp(NoParams params) async {
    final result = await _remoteDataSource.checkStatusApp(params);
    return result.mapValue(
      (StatusAppModel item) => item.toEntity(),
    );
  }
}
