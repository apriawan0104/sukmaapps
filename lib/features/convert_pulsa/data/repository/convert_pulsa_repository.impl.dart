import 'package:app_core/app_core.dart';

import '../../../../common/common.dart';
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
  Future<ValueGuard<void>> savePhoneFav(
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

  @override
  Future<ValueGuard<List<BankEntity>>> getListBank(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListBank(params);
    return result.mapListValue(
      (BankModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<List<RekeningFavEntity>>> getListRekeningFav(
    NoParams params,
  ) async {
    final result = await _remoteDataSource.getListRekeningFav(params);
    return result.mapListValue(
      (RekeningFavModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  ) async {
    await _remoteDataSource.deleteRekeningFav(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<void>> saveRekeningFav(
    SaveRekeningFavParam params,
  ) async {
    await _remoteDataSource.saveRekeningFav(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<TransferEntity>> saveTransKonfirm(
    SaveTransKonfirmParam params,
  ) async {
    final result = await _remoteDataSource.saveTransKonfirm(params);
    return result.mapValue(
      (TransferModel item) => item.toEntity(),
    );
  }

  @override
  Future<ValueGuard<void>> cancelTrans(CancelParam params) async {
    await _remoteDataSource.cancelTrans(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<void>> deleteImage(DeleteImageParam params) async {
    await _remoteDataSource.deleteImage(params);
    return ValueGuards.success(null);
  }

  @override
  Future<ValueGuard<void>> uploadImage(UploadImageParam params) async {
    await _remoteDataSource.uploadImage(params);
    return ValueGuards.success(null);
  }
}
