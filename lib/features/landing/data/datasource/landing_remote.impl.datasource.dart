import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../common/common.dart';
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
    return _remoteClient.get<Map<String, dynamic>>(
      WebServiceConstant.transHistory,
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => HistoryConvertModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<TransferModel>>> getOutstanding(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.transGet,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => TransferModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
