import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../model/model.dart';
import 'landing_remote.datasource.dart';

@LazySingleton(as: LandingRemoteDataSource)
class LandingRemoteImplDataSource implements LandingRemoteDataSource {
  LandingRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<List<BannerModel>>> getBanner(
    NoParams params,
  ) async {
    return _remoteClient
        .get<List<dynamic>>(
      WebServiceConstant.banner,
    )
        .mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<InformationBannerModel>>> getInformationBanner(
    NoParams params,
  ) async {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map(
              (e) => InformationBannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<RateModel>>> getRate(
    NoParams params,
  ) async {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => RateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<StatusAppModel>> checkStatusApp(NoParams params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      return StatusAppModel.fromJson(response.data ?? <String, dynamic>{});
    });
  }

  @override
  Future<ValueGuard<List<HistoryConvertModel>>> getHistoryConvert(
      NoParams params) {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => HistoryConvertModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
