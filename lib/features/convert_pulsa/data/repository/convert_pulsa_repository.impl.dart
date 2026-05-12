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
  Future<ValueGuard<PrefixEntity>> getPrefix(
    GetPrefixParam params,
  ) async {
    final result = await _remoteDataSource.getPrefix(params);
    return result.mapValue(
      (PrefixModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> saveNumberFav(
    SavePhoneFavParam params,
  ) async {
    await _remoteDataSource.saveNumberFav(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<List<PhoneFavEntity>>> getListPhoneFav(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListPhoneFav(params);
    return result.mapListValue(
      (PhoneFavModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  ) async {
    await _remoteDataSource.deletePhoneFav(params);
    return ValueGuards.success(null);
  }
}
