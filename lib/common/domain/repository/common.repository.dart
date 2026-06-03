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
}
