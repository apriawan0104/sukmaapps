import 'package:app_core/app_core.dart';

import '../../../../common/common.dart';
import '../entity/entity.dart';
import '../param/param.dart';

/// Template: VS Code snippet `reabs` (prefix `reabs`).
abstract class ConvertPulsaRepository {
  Future<ValueGuard<PrefixEntity>> getPrefix(
    GetPrefixParam params,
  );

  Future<ValueGuard<void>> savePhoneFav(
    SavePhoneFavParam params,
  );

  Future<ValueGuard<List<PhoneFavEntity>>> getListPhoneFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  );

  Future<ValueGuard<List<BankEntity>>> getListBank(
    NoParams params,
  );

  Future<ValueGuard<List<RekeningFavEntity>>> getListRekeningFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  );

  Future<ValueGuard<void>> saveRekeningFav(
    SaveRekeningFavParam params,
  );

  Future<ValueGuard<TransferEntity>> saveTransKonfirm(
    SaveTransKonfirmParam params,
  );

  Future<ValueGuard<void>> cancelTrans(
    CancelParam params,
  );

  Future<ValueGuard<void>> deleteImage(
    DeleteImageParam params,
  );

  Future<ValueGuard<void>> uploadImage(
    UploadImageParam params,
  );
}
