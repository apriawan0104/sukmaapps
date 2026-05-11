import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';

/// Template: VS Code snippet `reabs` (prefix `reabs`).
abstract class ConvertPulsaRepository {
  Future<ValueGuard<List<ConvertPulsaItemEntity>>> getListConvertPulsaItems(
    NoParams params,
  );

  Future<ValueGuard<ConvertPulsaItemEntity>> getConvertPulsaItem(
    GetConvertPulsaItemParams params,
  );
}
