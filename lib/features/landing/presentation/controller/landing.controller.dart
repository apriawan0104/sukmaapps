import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';

abstract class LandingController {
  /// Loads all landing data (initial open and pull-to-refresh).
  Future<void> loadInitial();

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

  Future<void> launchUrl(String url);

  Future<void> launchWhatsapp(String body);

  Future<void> openBannerUrl(String? url);

  Future<String> getVersion();

  Future<void> logout();

  Future<void> deleteAccount();
}
