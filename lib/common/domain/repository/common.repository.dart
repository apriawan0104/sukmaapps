import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';

abstract class CommonRepository {
  Future<ValueGuard<String>> getWaNumber(NoParams params);

  Future<ValueGuard<List<PhoneFavEntity>>> getListPhoneFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  );

  Future<ValueGuard<List<RekeningFavEntity>>> getListRekeningFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deleteRekeningFav(
    DeleteRekeningFavParam params,
  );

  Future<ValueGuard<void>> savePhoneFav(
    SavePhoneFavParam params,
  );

  Future<ValueGuard<void>> saveRekeningFav(
    SaveRekeningFavParam params,
  );

  Future<ValueGuard<PrefixEntity>> getPrefix(
    GetPrefixParam params,
  );

  Future<ValueGuard<List<TransferEntity>>> getOutstanding(
    NoParams params,
  );
}
