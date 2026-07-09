import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../model/model.dart';
import 'landing_remote.datasource.dart';

@LazySingleton(as: LandingRemoteDataSource)
class LandingRemoteImplDataSource implements LandingRemoteDataSource {
  LandingRemoteImplDataSource(this._remoteClient);

  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<List<BannerModel>>> getBanner(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.banner,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<InformationBannerModel>>> getInformationBanner(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.informationBanner,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map(
            (e) => InformationBannerModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<RateModel>>> getRate(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.rate,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => RateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<StatusAppModel>> checkStatusApp(NoParams params) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.statusApp,
    )
        .mapSuccess((response) {
      return StatusAppModel.fromJson(ApiResponse.unwrapMap(response.data));
    });
  }

  @override
  Future<ValueGuard<List<HistoryConvertModel>>> getHistoryConvert(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.transHistory,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => HistoryConvertModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<SocialMediaModel>>> getSocialMedia(
      NoParams params) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.socialMedia,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => SocialMediaModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
