import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';

/// Template: VS Code snippet `dsabs` (prefix `dsabs`).
abstract class ConvertPulsaRemoteDataSource {
  Future<ValueGuard<PrefixModel>> getPrefix(
    GetPrefixParam params,
  );

  Future<ValueGuard<void>> saveNumberFav(
    SavePhoneFavParam params,
  );

  Future<ValueGuard<List<PhoneFavModel>>> getListPhoneFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  );

  Future<ValueGuard<List<BankModel>>> getListBank(
    NoParams params,
  );

  Future<ValueGuard<List<RekeningFavModel>>> getListRekeningFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  );

  Future<ValueGuard<void>> saveRekeningFav(
    SaveRekeningFavParam params,
  );

  Future<ValueGuard<TransferModel>> saveTransKonfirm(
    SaveTransKonfirmParam params,
  );
}
