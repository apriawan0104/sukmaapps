import 'package:app_core/app_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:sukmaapps/common/domain/entity/phone_fav.entity.dart';
import 'package:sukmaapps/common/domain/usecase/get_wa_number.usecase.dart';
import 'package:sukmaapps/core/core.dart';
import 'package:sukmaapps/common/domain/entity/rekening_fav.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/history_convert.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/information_banner.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/rate.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/status_app.entity.dart';
import '../../../auth/domain/domain.dart';
import '../../domain/domain.dart';
import '../controller/landing.controller.dart';
import '../state/landing.state.dart';
part 'landing.adapter.g.dart';

@riverpod
class LandingRiverpodAdapter extends _$LandingRiverpodAdapter
    implements LandingController {
  late UrlLauncherService _urlLauncherService;
  late GetWaNumberUseCase _getWaNumberUseCase;
  late GetBannerUseCase _getBannerUseCase;
  late LogoutUseCase _logoutUseCase;
  late DeleteAccountUseCase _deleteAccountUseCase;

  void _initDependencies() {
    _urlLauncherService = getIt<UrlLauncherService>();
    _getWaNumberUseCase = getIt<GetWaNumberUseCase>();
    _getBannerUseCase = getIt<GetBannerUseCase>();
    _logoutUseCase = getIt<LogoutUseCase>();
    _deleteAccountUseCase = getIt<DeleteAccountUseCase>();
  }

  @override
  LandingState build() {
    _initDependencies();
    Future.microtask(loadInitial);
    return const LandingState();
  }

  @override
  Future<void> loadInitial() async {
    await Future.wait<void>([
      getBanner(),
      getInformationBanner(),
      getRate(),
      checkStatusApp(),
      getHistoryConvert(),
      getPhoneFav(),
      getRekeningFav(),
    ], eagerError: false);
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
    state = state.copyWith(banner: const AsyncValue.loading());
    final result = await _getBannerUseCase(NoParams());
    state = state.copyWith(
      banner: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
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
  Future<void> launchUrl(String url) async {
    await _urlLauncherService.launchWebUrl(url);
  }

  @override
  Future<void> launchWhatsapp(String body) async {
    var waNumber = EnvConstant.csPhone.env;
    if (waNumber == '-') {
      return;
    }

    final waResult = await _getWaNumberUseCase(NoParams());
    waResult.fold(
      (_) {},
      (number) {
        if (number.isNotEmpty) {
          waNumber = number;
        }
      },
    );

    if (waNumber.startsWith('0')) {
      waNumber = '62${waNumber.substring(1)}';
    }

    final url = 'https://wa.me/$waNumber?text=${Uri.encodeComponent(body)}';
    await launchUrl(url);
  }

  @override
  Future<void> openBannerUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    await launchUrl(url);
  }

  @override
  Future<String> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<void> logout() async {
    final result = await _logoutUseCase(NoParams());
    result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
  }

  @override
  Future<void> deleteAccount() async {
    // final userId =
    //     await getIt<StorageService>().get<String>(StorageConstants.userId);
    // if (userId == null) {
    //   return;
    // }
    // final result =
    //     await _deleteAccountUseCase(DeleteAccountParams(userId: userId));
    // result.fold(
    //   (failure) => AsyncValue.error(failure.message),
    //   AsyncValue.data,
    // );
  }
}
