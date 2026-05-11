import 'package:app_core/app_core.dart';

import '../../domain/param/param.dart';
import '../model/model.dart';

/// Template: VS Code snippet `dsabs` (prefix `dsabs`).
abstract class LandingRemoteDataSource {
  Future<ValueGuard<List<LandingItemModel>>> getListLandingItems(
    NoParams params,
  );

  Future<ValueGuard<LandingItemModel>> getLandingItem(
    GetLandingItemParams params,
  );
}
