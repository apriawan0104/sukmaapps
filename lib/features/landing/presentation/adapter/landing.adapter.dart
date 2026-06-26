import 'package:app_core/app_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:sukmaapps/common/common.dart';
import 'package:sukmaapps/config/config.dart';
import '../../../auth/domain/domain.dart';
import '../../domain/domain.dart';
import '../controller/landing.controller.dart';
import '../guard/convert_pulsa_navigation.dart';
import '../state/landing.state.dart';
part 'landing.adapter.g.dart';

@riverpod
class LandingRiverpodAdapter extends _$LandingRiverpodAdapter
    implements LandingController {
  late UrlLauncherService _urlLauncherService;
  late GetBannerUseCase _getBannerUseCase;
  late GetInformationBannerUseCase _getInformationBannerUseCase;
  late GetRateUseCase _getRateUseCase;
  late GetOutstandingUseCase _getOutstandingUseCase;
  late CheckStatusAppUseCase _checkStatusAppUseCase;
  late GetHistoryConvertUseCase _getHistoryConvertUseCase;
  late GetPhoneFavUseCase _getPhoneFavUseCase;
  late DeletePhoneFavUseCase _deletePhoneFavUseCase;
  late GetRekeningFavUseCase _getRekeningFavUseCase;
  late DeleteRekeningFavUseCase _deleteRekeningFavUseCase;
  late LogoutUseCase _logoutUseCase;
  late DeleteAccountUseCase _deleteAccountUseCase;
  late GetLocalUserUseCase _getLocalUserUseCase;
  late GetStatusTransaksiFailedUseCase _getStatusTransaksiFailedUseCase;
  late LaunchWhatsappUseCase _launchWhatsappUseCase;

  Future<void>? _outstandingRequest;

  void _initDependencies() {
    _urlLauncherService = getIt<UrlLauncherService>();
    _getBannerUseCase = getIt<GetBannerUseCase>();
    _getInformationBannerUseCase = getIt<GetInformationBannerUseCase>();
    _getRateUseCase = getIt<GetRateUseCase>();
    _getOutstandingUseCase = getIt<GetOutstandingUseCase>();
    _checkStatusAppUseCase = getIt<CheckStatusAppUseCase>();
    _getHistoryConvertUseCase = getIt<GetHistoryConvertUseCase>();
    _getPhoneFavUseCase = getIt<GetPhoneFavUseCase>();
    _deletePhoneFavUseCase = getIt<DeletePhoneFavUseCase>();
    _getRekeningFavUseCase = getIt<GetRekeningFavUseCase>();
    _deleteRekeningFavUseCase = getIt<DeleteRekeningFavUseCase>();
    _logoutUseCase = getIt<LogoutUseCase>();
    _deleteAccountUseCase = getIt<DeleteAccountUseCase>();
    _getLocalUserUseCase = getIt<GetLocalUserUseCase>();
    _getStatusTransaksiFailedUseCase = getIt<GetStatusTransaksiFailedUseCase>();
    _launchWhatsappUseCase = getIt<LaunchWhatsappUseCase>();
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
      getOutstanding(),
      checkStatusApp(),
      getHistoryConvert(),
      getPhoneFav(),
      getRekeningFav(),
      getLocalUser(),
    ], eagerError: false);
  }

  @override
  void changeIndexNav(int index) {
    state = state.copyWith(indexNav: index);
  }

  @override
  Future<void> checkStatusApp() async {
    state = state.copyWith(banner: const AsyncValue.loading());
    final result = await _checkStatusAppUseCase(NoParams());
    state = state.copyWith(
      statusApp: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
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
  Future<List<HistoryConvertEntity>> getHistoryConvert() async {
    state = state.copyWith(historyConvert: const AsyncValue.loading());
    final result = await _getHistoryConvertUseCase(NoParams());
    final AsyncValue<List<HistoryConvertEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(historyConvert: asyncValue);
    return asyncValue.value ?? [];
  }

  @override
  Future<List<InformationBannerEntity>> getInformationBanner() async {
    state = state.copyWith(informationBanner: const AsyncValue.loading());
    final result = await _getInformationBannerUseCase(NoParams());
    final AsyncValue<List<InformationBannerEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(informationBanner: asyncValue);
    return asyncValue.data ?? [];
  }

  @override
  Future<List<PhoneFavEntity>> getPhoneFav() async {
    state = state.copyWith(phoneFav: const AsyncValue.loading());
    final result = await _getPhoneFavUseCase(NoParams());
    final AsyncValue<List<PhoneFavEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(phoneFav: asyncValue);
    return asyncValue.value ?? [];
  }

  @override
  Future<List<RateEntity>> getRate() async {
    state = state.copyWith(rate: const AsyncValue.loading());
    final result = await _getRateUseCase(NoParams());
    final AsyncValue<List<RateEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(rate: asyncValue);
    return asyncValue.data ?? [];
  }

  @override
  Future<void> refreshOutstanding() => getOutstanding(showLoading: false);

  @override
  void clearOutstanding() {
    state = state.copyWith(outstanding: const AsyncValue.data(null));
  }

  /// Fetches outstanding transaction for home card.
  ///
  /// Refresh triggers (one API call each, deduped when concurrent):
  /// - [loadInitial] — landing mount / pull-to-refresh
  /// - [syncLandingOutstandingIfActive] — transfer pop while home still mounted
  /// - [clearLandingOutstandingIfActive] — cancel/submit success (no API)
  /// - [TransferPage] pop — pushNamed back to home
  /// - [HomePage] tab switch / countdown expired / retry button
  @override
  Future<void> getOutstanding({bool showLoading = true}) async {
    if (_outstandingRequest != null) {
      return _outstandingRequest;
    }

    _outstandingRequest = _fetchOutstanding(showLoading: showLoading);
    try {
      await _outstandingRequest;
    } finally {
      _outstandingRequest = null;
    }
  }

  Future<void> _fetchOutstanding({required bool showLoading}) async {
    final hasCachedData = state.outstanding.hasValue;

    if (showLoading || !hasCachedData) {
      state = state.copyWith(outstanding: const AsyncValue.loading());
    }

    final result = await _getOutstandingUseCase(NoParams());
    state = state.copyWith(
      outstanding: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<List<RekeningFavEntity>> getRekeningFav() async {
    state = state.copyWith(rekeningFav: const AsyncValue.loading());
    final result = await _getRekeningFavUseCase(NoParams());
    final AsyncValue<List<RekeningFavEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(rekeningFav: asyncValue);
    return asyncValue.value ?? [];
  }

  @override
  Future<void> deletePhoneFav(String id) async {
    final result = await _deletePhoneFavUseCase(DeletePhoneFavParam(id: id));
    result.fold(
      (failure) {
        state = state.copyWith(
          phoneFav: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        await getPhoneFav();
      },
    );
  }

  @override
  Future<void> deleteRekeningFav(String id) async {
    final result =
        await _deleteRekeningFavUseCase(DeleteRekeningFavParam(id: id));
    result.fold(
      (failure) {
        state = state.copyWith(
          rekeningFav: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        await getRekeningFav();
      },
    );
  }

  @override
  Future<void> launchUrl(String url) async {
    await _urlLauncherService.launchWebUrl(url);
  }

  @override
  Future<void> launchWhatsapp(String body) async {
    await _launchWhatsappUseCase(LaunchWhatsappParam(body: body));
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
  Future<List<StatusTransaksiEntity>> getStatusTransaksiFailed() async {
    state = state.copyWith(statusTransaksiFailed: const AsyncValue.loading());
    final result = await _getStatusTransaksiFailedUseCase(NoParams());
    final AsyncValue<List<StatusTransaksiEntity>> asyncValue = result.fold(
      (failure) => AsyncValue.error(failure.message),
      AsyncValue.data,
    );
    state = state.copyWith(statusTransaksiFailed: asyncValue);
    return asyncValue.value ?? [];
  }

  @override
  Future<void> getLocalUser() async {
    state = state.copyWith(localUser: const AsyncValue.loading());
    final result = await _getLocalUserUseCase(NoParams());
    state = state.copyWith(
      localUser: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<void> logout() async {
    final result = await _logoutUseCase(NoParams());
    result.fold(
      FailurePresenter.show,
      (_) => appRouter.goNamed(RouteNames.login),
    );
  }

  @override
  Future<void> deleteAccount() async {
    var userId = state.localUser.value?.userId ?? '';
    if (userId.isEmpty) {
      final localUserResult = await _getLocalUserUseCase(NoParams());
      userId = localUserResult.fold((_) => '', (user) => user.userId);
    }
    if (userId.isEmpty) {
      return;
    }

    await _deleteAccountUseCase(DeleteAccountParams(userId: userId));

    StaticWidget.msgToast(
      'Akun berhasil dihapus. Silakan gunakan email lain untuk melanjutkan',
    );
    appRouter.goNamed(RouteNames.login);
  }
  @override
  Future<void> convertPulsa() => ConvertPulsaNavigation.pushPhone();
}
