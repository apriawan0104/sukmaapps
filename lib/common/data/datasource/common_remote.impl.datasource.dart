import 'package:app_core/app_core.dart';

import '../model/model.dart';
import 'common_remote.datasource.dart';

/// Stub: belum memanggil jaringan; kembalikan daftar kosong sampai endpoint siap.
class CommonRemoteImplDataSource implements CommonRemoteDataSource {
  CommonRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<List<CommonItemModel>>> getItems(NoParams params) async {
    return ValueGuards.success(<CommonItemModel>[]);
  }
}
