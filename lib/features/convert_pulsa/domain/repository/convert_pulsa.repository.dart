import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';

/// Template: VS Code snippet `reabs` (prefix `reabs`).
abstract class ConvertPulsaRepository {
  Future<ValueGuard<PrefixEntity>> getPrefix(
    GetPrefixParam params,
  );

  Future<ValueGuard<void>> saveNumberFav(
    SavePhoneFavParam params,
  );

  Future<ValueGuard<List<PhoneFavEntity>>> getListPhoneFav(
    NoParams params,
  );

  Future<ValueGuard<void>> deletePhoneFav(
    DeletePhoneFavParam params,
  );
}
