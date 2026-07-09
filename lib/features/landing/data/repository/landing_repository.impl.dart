import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/entity.dart';
import '../../domain/repository/landing.repository.dart';
import '../datasource/landing_remote.datasource.dart';
import '../model/model.dart';

@LazySingleton(as: LandingRepository)
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

  @override
  Future<ValueGuard<List<HistoryConvertEntity>>> getHistoryConvert(
      NoParams params) async {
    final result = await _remoteDataSource.getHistoryConvert(params);
    return result.mapListValue(
      (HistoryConvertModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<List<SocialMediaEntity>>> getSocialMedia(
      NoParams params) async {
    final result = await _remoteDataSource.getSocialMedia(params);
    return result.mapListValue(
      (SocialMediaModel item) => item.toEntity(),
    );
  }
}
