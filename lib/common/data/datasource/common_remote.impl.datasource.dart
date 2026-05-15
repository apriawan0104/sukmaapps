import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
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
}
