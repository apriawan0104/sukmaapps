import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';
import 'common_remote.datasource.dart';

@LazySingleton(as: CommonRemoteDataSource)
class CommonRemoteImplDataSource implements CommonRemoteDataSource {
  CommonRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<TransferModel>> getListTransfer(NoParams params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => TransferModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Future<ValueGuard<String>> getWaNumber(NoParams params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => response.data?['wa_number'] ?? '',
    );
  }

  @override
  Future<ValueGuard<void>> deletePhoneFav(DeletePhoneFavParam params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => response.data,
    );
  }

  @override
  Future<ValueGuard<List<PhoneFavModel>>> getListPhoneFav(NoParams params) {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => PhoneFavModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  ) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => response.data,
    );
  }

  @override
  Future<ValueGuard<List<RekeningFavModel>>> getListRekeningFav(
    NoParams params,
  ) async {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => RekeningFavModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
