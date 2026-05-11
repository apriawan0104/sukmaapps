import 'package:app_core/app_core.dart';

import '../entity/entity.dart';
import '../param/param.dart';

/// Template: VS Code snippet `reabs` (prefix `reabs`).
abstract class LandingRepository {
  Future<ValueGuard<List<LandingItemEntity>>> getListLandingItems(
    NoParams params,
  );

  Future<ValueGuard<LandingItemEntity>> getLandingItem(
    GetLandingItemParams params,
  );
}
