import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';

abstract class LandingController {
  /// Loads all landing data (initial open and pull-to-refresh).
  Future<void> loadInitial();

  /// Load many; result lives in [State] (List / pagination).
  Future<void> getBanner();

  Future<List<InformationBannerEntity>> getInformationBanner();

  Future<List<RateEntity>> getRate();

  Future<void> getOutstanding({bool showLoading = true});

  /// Silent refresh — no loading shimmer when data already exists.
  Future<void> refreshOutstanding();

  /// Clears home outstanding card without API (after cancel/submit success).
  void clearOutstanding();

  Future<void> checkStatusApp();

  Future<List<HistoryConvertEntity>> getHistoryConvert();

  Future<List<PhoneFavEntity>> getPhoneFav();

  Future<List<RekeningFavEntity>> getRekeningFav();

  Future<void> deletePhoneFav(String id);

  Future<void> deleteRekeningFav(String id);

  void changeIndexNav(int index);

  Future<void> launchUrl(String url);

  Future<void> launchWhatsapp(String body);

  Future<void> openBannerUrl(String? url);

  Future<String> getVersion();

  Future<void> logout();

  Future<void> deleteAccount();

  Future<void> getLocalUser();

  Future<List<StatusTransaksiEntity>> getStatusTransaksiFailed();

  Future<void> convertPulsa();

  Future<void> getSocialMedia();
}
