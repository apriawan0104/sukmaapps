import 'package:app_core/app_core.dart';

import '../../../../common/common.dart';
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

  Future<ValueGuard<List<BankModel>>> getListBank(
    NoParams params,
  );

  Future<ValueGuard<void>> saveRekeningFav(
    SaveRekeningFavParam params,
  );

  Future<ValueGuard<TransferModel>> saveTransKonfirm(
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
