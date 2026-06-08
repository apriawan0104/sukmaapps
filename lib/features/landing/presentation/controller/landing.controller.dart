import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';

abstract class LandingController {
  /// Load many; result lives in [State] (List / pagination).
  Future<void> getBanner();

  Future<List<InformationBannerEntity>> getInformationBanner();

  Future<List<RateEntity>> getRate();

  Future<StatusAppEntity> checkStatusApp();

  Future<List<HistoryConvertEntity>> getHistoryConvert();

  Future<List<PhoneFavEntity>> getPhoneFav();

  Future<List<RekeningFavEntity>> getRekeningFav();

  Future<void> removePhoneFav({required String phoneNumber});

  Future<void> removeRekeningFav();

  void changeIndexNav(int index);

  Future<void> openBannerUrl(String? url);
}
