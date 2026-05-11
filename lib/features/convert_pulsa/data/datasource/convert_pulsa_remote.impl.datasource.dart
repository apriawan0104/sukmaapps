import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';
import 'convert_pulsa_remote.datasource.dart';

/// Template: VS Code snippet `dsimp` (prefix `dsimp`).
/// Stub: tidak memanggil jaringan; kembalikan daftar kosong sampai endpoint siap.
class ConvertPulsaRemoteImplDataSource implements ConvertPulsaRemoteDataSource {
  ConvertPulsaRemoteImplDataSource(this._remoteClient);

  // ignore: unused_field
  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<List<ConvertPulsaItemModel>>> getListConvertPulsaItems(
    NoParams params,
  ) async {
    return ValueGuards.success(<ConvertPulsaItemModel>[]);
  }

  @override
  Future<ValueGuard<ConvertPulsaItemModel>> getConvertPulsaItem(
    GetConvertPulsaItemParams params,
  ) async {
    return ValueGuards.success(
      ConvertPulsaItemModel(id: params.id),
    );
  }
}
