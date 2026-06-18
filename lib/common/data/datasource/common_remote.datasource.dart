import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';

abstract class CommonRemoteDataSource {
  Future<ValueGuard<List<TransferModel>>> getOutstanding(NoParams params);

  Future<ValueGuard<String>> getWaNumber(NoParams params);

  Future<ValueGuard<List<PhoneFavModel>>> getListPhoneFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  );

  Future<ValueGuard<List<RekeningFavModel>>> getListRekeningFav(
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

  Future<ValueGuard<PrefixModel>> getPrefix(
    GetPrefixParam params,
  );

  Future<ValueGuard<List<StatusTransaksiModel>>> getStatusTransaksiFailed(
    NoParams params,
  );
}
