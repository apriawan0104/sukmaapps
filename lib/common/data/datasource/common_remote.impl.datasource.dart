import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';
import 'common_remote.datasource.dart';

@LazySingleton(as: CommonRemoteDataSource)
class CommonRemoteImplDataSource implements CommonRemoteDataSource {
  CommonRemoteImplDataSource(this._remoteClient);

  final HttpClient _remoteClient;

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

  @override
  Future<ValueGuard<String>> getWaNumber(NoParams params) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
          WebServiceConstant.waNumber,
        )
        .mapSuccess(
          (response) =>
              ApiResponse.unwrapMap(response.data)['wa_number'] as String? ??
              '',
        );
  }

  @override
  Future<ValueGuard<void>> deletePhoneFav(DeletePhoneFavParam params) {
    return _remoteClient
        .delete<Map<String, dynamic>>(
          '${WebServiceConstant.number}/${params.id}',
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<List<PhoneFavModel>>> getListPhoneFav(NoParams params) {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.number,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => PhoneFavModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  ) async {
    return _remoteClient.delete<Map<String, dynamic>>(
      '${WebServiceConstant.rekening}/${params.id}',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<List<RekeningFavModel>>> getListRekeningFav(
    NoParams params,
  ) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.rekening,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => RekeningFavModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<void>> savePhoneFav(SavePhoneFavParam params) {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.number,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> saveRekeningFav(SaveRekeningFavParam params) {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.rekening,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<PrefixModel>> getPrefix(GetPrefixParam params) {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.prefix,
          data: params.toJson(),
        )
        .mapSuccess(
          (response) => PrefixModel.fromJson(
            ApiResponse.unwrapMap(response.data),
          ),
        );
  }

  @override
  Future<ValueGuard<List<StatusTransaksiModel>>> getStatusTransaksiFailed(
    NoParams params,
  ) {
    return _remoteClient
        .get<Map<String, dynamic>>(
          WebServiceConstant.statusTransaksiFailed,
        )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map(
            (e) => StatusTransaksiModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    });
  }
}
