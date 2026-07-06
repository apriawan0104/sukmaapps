import 'package:app_core/app_core.dart';

import '../model/model.dart';

/// Template: VS Code snippet `dsabs` (prefix `dsabs`).
abstract class LandingRemoteDataSource {
  Future<ValueGuard<List<BannerModel>>> getBanner(
    NoParams params,
  );

  Future<ValueGuard<List<InformationBannerModel>>> getInformationBanner(
    NoParams params,
  );

  Future<ValueGuard<List<RateModel>>> getRate(
    NoParams params,
  );

  Future<ValueGuard<StatusAppModel>> checkStatusApp(
    NoParams params,
  );

  Future<ValueGuard<List<HistoryConvertModel>>> getHistoryConvert(
    NoParams params,
  );

  Future<ValueGuard<List<SocialMediaModel>>> getSocialMedia(
    NoParams params,
  );
}
