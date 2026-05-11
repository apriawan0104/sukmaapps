import 'package:app_core/app_core.dart';

import '../../domain/entity/entity.dart';
import '../../domain/param/param.dart';
import '../../domain/repository/convert_pulsa.repository.dart';
import '../datasource/convert_pulsa_remote.datasource.dart';
import '../model/model.dart';

/// Template: VS Code snippet `reimp` (prefix `reimp`).
class ConvertPulsaImplRepository implements ConvertPulsaRepository {
  ConvertPulsaImplRepository(this._remoteDataSource);

  final ConvertPulsaRemoteDataSource _remoteDataSource;

  @override
  Future<ValueGuard<List<ConvertPulsaItemEntity>>> getListConvertPulsaItems(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListConvertPulsaItems(params);
    return result.mapListValue(
      (ConvertPulsaItemModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<ConvertPulsaItemEntity>> getConvertPulsaItem(
    GetConvertPulsaItemParams params,
  ) async {
    final result = await _remoteDataSource.getConvertPulsaItem(params);
    return result.mapValue(
      (ConvertPulsaItemModel item) => item.toEntity(),
    );
  }
}
