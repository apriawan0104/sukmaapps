import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';

abstract class CommonRemoteDataSource {
  Future<ValueGuard<TransferModel>> getListTransfer(NoParams params);
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
}
