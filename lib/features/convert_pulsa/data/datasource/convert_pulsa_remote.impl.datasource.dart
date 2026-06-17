import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../common/common.dart';
import '../../domain/param/param.dart';
import '../model/model.dart';
import 'convert_pulsa_remote.datasource.dart';

@LazySingleton(as: ConvertPulsaRemoteDataSource)
class ConvertPulsaRemoteImplDataSource implements ConvertPulsaRemoteDataSource {
  ConvertPulsaRemoteImplDataSource(this._remoteClient);

  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<void>> saveNumberFav(SavePhoneFavParam params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<List<BankModel>>> getListBank(NoParams params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<void>> saveRekeningFav(SaveRekeningFavParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<TransferModel>> saveTransKonfirm(
    SaveTransKonfirmParam params,
  ) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => TransferModel.fromJson(
        ApiResponse.unwrapMap(response.data),
      ),
    );
  }

  @override
  Future<ValueGuard<void>> cancelTrans(CancelParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> deleteImage(DeleteImageParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> uploadImage(UploadImageParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((_) {});
  }
}
