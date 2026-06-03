import 'package:app_core/app_core.dart';

import '../entity/entity.dart';

/// Template: VS Code snippet `reabs` (prefix `reabs`).
abstract class LandingRepository {
  Future<ValueGuard<List<BannerEntity>>> getBanner(
    NoParams params,
  );

  Future<ValueGuard<List<InformationBannerEntity>>> getInformationBanner(
    NoParams params,
  );

  Future<ValueGuard<List<RateEntity>>> getRate(
    NoParams params,
  );

  Future<ValueGuard<StatusAppEntity>> checkStatusApp(
    NoParams params,
  );

  Future<ValueGuard<List<HistoryConvertEntity>>> getHistoryConvert(
    NoParams params,
  );
}
