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
}
