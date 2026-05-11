import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';

/// Template: VS Code snippet `dsabs` (prefix `dsabs`).
abstract class ConvertPulsaRemoteDataSource {
  Future<ValueGuard<List<ConvertPulsaItemModel>>> getListConvertPulsaItems(
    NoParams params,
  );

  Future<ValueGuard<ConvertPulsaItemModel>> getConvertPulsaItem(
    GetConvertPulsaItemParams params,
  );
}
