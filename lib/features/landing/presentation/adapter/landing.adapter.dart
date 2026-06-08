import 'package:app_core/app_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:sukmaapps/common/domain/entity/phone_fav.entity.dart';
import 'package:sukmaapps/common/domain/entity/rekening_fav.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/banner.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/history_convert.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/information_banner.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/rate.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/status_app.entity.dart';
import '../../domain/domain.dart';
import '../controller/landing.controller.dart';
import '../state/landing.state.dart';
part 'landing.adapter.g.dart';

@riverpod
class LandingRiverpodAdapter extends _$LandingRiverpodAdapter
    implements LandingController {
  late UrlLauncherService _urlLauncherService;
  late GetBannerUseCase _getBannerUseCase;

  void _initDependencies() {
    _urlLauncherService = getIt<UrlLauncherService>();
    _getBannerUseCase = getIt<GetBannerUseCase>();
  }

  @override
  LandingState build() {
    _initDependencies();
    return const LandingState();
  }

  @override
  void changeIndexNav(int index) {
    state = state.copyWith(indexNav: index);
  }

  @override
  Future<StatusAppEntity> checkStatusApp() {
    // TODO: implement checkStatusApp
    throw UnimplementedError();
  }

  @override
  Future<void> getBanner() async {
    final result = await _getBannerUseCase(NoParams());
    state = state.copyWith(
        banner: result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    ));
  }

  @override
  Future<List<HistoryConvertEntity>> getHistoryConvert() {
    // TODO: implement getHistoryConvert
    throw UnimplementedError();
  }

  @override
  Future<List<InformationBannerEntity>> getInformationBanner() {
    // TODO: implement getInformationBanner
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneFavEntity>> getPhoneFav() {
    // TODO: implement getPhoneFav
    throw UnimplementedError();
  }

  @override
  Future<List<RateEntity>> getRate() {
    // TODO: implement getRate
    throw UnimplementedError();
  }

  @override
  Future<List<RekeningFavEntity>> getRekeningFav() {
    // TODO: implement getRekeningFav
    throw UnimplementedError();
  }

  @override
  Future<void> removePhoneFav({required String phoneNumber}) {
    // TODO: implement removePhoneFav
    throw UnimplementedError();
  }

  @override
  Future<void> removeRekeningFav() {
    // TODO: implement removeRekeningFav
    throw UnimplementedError();
  }

  @override
  Future<void> openBannerUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    await _urlLauncherService.launchWebUrl(url);
  }
}
