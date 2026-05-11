import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';
import 'landing_remote.datasource.dart';

/// Template: VS Code snippet `dsimp` (prefix `dsimp`).
/// Stub: tidak memanggil jaringan; kembalikan daftar kosong sampai endpoint siap.
class LandingRemoteImplDataSource implements LandingRemoteDataSource {
  LandingRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<List<LandingItemModel>>> getListLandingItems(
    NoParams params,
  ) async {
    return ValueGuards.success(<LandingItemModel>[]);
  }

  @override
  Future<ValueGuard<LandingItemModel>> getLandingItem(
    GetLandingItemParams params,
  ) async {
    return ValueGuards.success(
      LandingItemModel(id: params.id),
    );
  }
}
