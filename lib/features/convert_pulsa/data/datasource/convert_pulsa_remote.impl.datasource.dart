import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';
import 'convert_pulsa_remote.datasource.dart';

@LazySingleton(as: ConvertPulsaRemoteDataSource)
class ConvertPulsaRemoteImplDataSource implements ConvertPulsaRemoteDataSource {
  ConvertPulsaRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<void>> deletePhoneFav(DeletePhoneFavParam params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => PrefixModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
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
  Future<ValueGuard<PrefixModel>> getPrefix(GetPrefixParam params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => PrefixModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Future<ValueGuard<void>> saveNumberFav(SavePhoneFavParam params) {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => PrefixModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Future<ValueGuard<void>> deleteRekeningFav(
      DeleteRekeningFavParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => PrefixModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Future<ValueGuard<List<BankModel>>> getListBank(NoParams params) async {
    return _remoteClient.get<List<dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess((response) {
      final items = response.data ?? <dynamic>[];
      return items
          .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<List<RekeningFavModel>>> getListRekeningFav(
      NoParams params) async {
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

  @override
  Future<ValueGuard<void>> saveRekeningFav(SaveRekeningFavParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) => PrefixModel.fromJson(
        response.data ?? <String, dynamic>{},
      ),
    );
  }

  @override
  Future<ValueGuard<TransferModel>> saveTransKonfirm(
      SaveTransKonfirmParam params) async {
    return _remoteClient.get<Map<String, dynamic>>(
      '/endpointPath',
      queryParameters: const {'ver': 'v1'},
    ).mapSuccess(
      (response) =>
          TransferModel.fromJson(response.data ?? <String, dynamic>{}),
    );
  }
}
