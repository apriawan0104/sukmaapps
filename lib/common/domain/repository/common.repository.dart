import 'package:app_core/app_core.dart';

import '../entity/entity.dart';

/// Kontrak data fitur common; implementasi di `data/repository/`.
abstract class CommonRepository {
  Future<ValueGuard<List<CommonItemEntity>>> getItems(NoParams params);
}
