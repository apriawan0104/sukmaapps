// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_core/app_core.dart' as _i130;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sukmaapps/common/data/datasource/common_remote.datasource.dart'
    as _i493;
import 'package:sukmaapps/common/data/datasource/common_remote.impl.datasource.dart'
    as _i871;
import 'package:sukmaapps/common/data/repository/common_repository.impl.dart'
    as _i564;
import 'package:sukmaapps/common/domain/repository/common.repository.dart'
    as _i852;
import 'package:sukmaapps/common/domain/usecase/delete_phone_fav.usecase.dart'
    as _i178;
import 'package:sukmaapps/common/domain/usecase/delete_rekening_fav.usecase.dart'
    as _i780;
import 'package:sukmaapps/common/domain/usecase/get_outstanding.usecase.dart'
    as _i509;
import 'package:sukmaapps/common/domain/usecase/get_phone_fav.usecase.dart'
    as _i945;
import 'package:sukmaapps/common/domain/usecase/get_prefix.usecase.dart'
    as _i429;
import 'package:sukmaapps/common/domain/usecase/get_rekening_fav.usecase.dart'
    as _i584;
import 'package:sukmaapps/common/domain/usecase/get_status_transaksi_failed.usecase.dart'
    as _i575;
import 'package:sukmaapps/common/domain/usecase/get_wa_number.usecase.dart'
    as _i389;
import 'package:sukmaapps/common/domain/usecase/save_phone_fav.usecase.dart'
    as _i278;
import 'package:sukmaapps/common/domain/usecase/save_rekening_fav.usecase.dart'
    as _i516;
import 'package:sukmaapps/config/di/app_core_module.dart' as _i493;
import 'package:sukmaapps/config/di/session_token_provider.service.dart'
    as _i766;
import 'package:sukmaapps/config/di/sukma_module.dart' as _i963;
import 'package:sukmaapps/features/auth/data/datasource/datasource.dart'
    as _i787;
import 'package:sukmaapps/features/auth/data/datasource/local/auth_local.datasource.dart'
    as _i919;
import 'package:sukmaapps/features/auth/data/datasource/local/auth_local.impl.datasource.dart'
    as _i366;
import 'package:sukmaapps/features/auth/data/datasource/remote/auth_remote.datasource.dart'
    as _i977;
import 'package:sukmaapps/features/auth/data/datasource/remote/auth_remote.impl.datasource.dart'
    as _i15;
import 'package:sukmaapps/features/auth/data/repository/auth_repository.impl.dart'
    as _i84;
import 'package:sukmaapps/features/auth/domain/domain.dart' as _i647;
import 'package:sukmaapps/features/auth/domain/repository/auth_repository.dart'
    as _i800;
import 'package:sukmaapps/features/auth/domain/usecase/delete_account.usecase.dart'
    as _i76;
import 'package:sukmaapps/features/auth/domain/usecase/get_local_user.usecase.dart'
    as _i879;
import 'package:sukmaapps/features/auth/domain/usecase/login_apple.usecase.dart'
    as _i761;
import 'package:sukmaapps/features/auth/domain/usecase/login_google.usecase.dart'
    as _i476;
import 'package:sukmaapps/features/auth/domain/usecase/logout.usecase.dart'
    as _i939;
import 'package:sukmaapps/features/auth/domain/usecase/read_term.usecase.dart'
    as _i655;
import 'package:sukmaapps/features/auth/domain/usecase/refresh_token.usecase.dart'
    as _i488;
import 'package:sukmaapps/features/convert_pulsa/data/datasource/convert_pulsa_remote.datasource.dart'
    as _i355;
import 'package:sukmaapps/features/convert_pulsa/data/datasource/convert_pulsa_remote.impl.datasource.dart'
    as _i587;
import 'package:sukmaapps/features/convert_pulsa/data/repository/convert_pulsa_repository.impl.dart'
    as _i827;
import 'package:sukmaapps/features/convert_pulsa/domain/repository/convert_pulsa.repository.dart'
    as _i342;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/cancel_trans.usecase.dart'
    as _i139;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/delete_image.usecase.dart'
    as _i1006;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/get_bank.usecase.dart'
    as _i161;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/save_trans_konfirm.usecase.dart'
    as _i497;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/trans_evidence.usecase.dart'
    as _i1018;
import 'package:sukmaapps/features/convert_pulsa/domain/usecase/upload_image.usecase.dart'
    as _i279;
import 'package:sukmaapps/features/landing/data/datasource/landing_remote.datasource.dart'
    as _i312;
import 'package:sukmaapps/features/landing/data/datasource/landing_remote.impl.datasource.dart'
    as _i1015;
import 'package:sukmaapps/features/landing/data/repository/landing_repository.impl.dart'
    as _i541;
import 'package:sukmaapps/features/landing/domain/repository/landing.repository.dart'
    as _i305;
import 'package:sukmaapps/features/landing/domain/usecase/check_status_app.usecase.dart'
    as _i971;
import 'package:sukmaapps/features/landing/domain/usecase/get_banner.usecase.dart'
    as _i545;
import 'package:sukmaapps/features/landing/domain/usecase/get_history_convert.usecase.dart'
    as _i829;
import 'package:sukmaapps/features/landing/domain/usecase/get_information_banner.usecase.dart'
    as _i448;
import 'package:sukmaapps/features/landing/domain/usecase/get_rate.usecase.dart'
    as _i779;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sukmaModule = _$SukmaModule();
    final appCoreModule = _$AppCoreModule();
    gh.lazySingleton<_i130.NetworkConfig>(() => sukmaModule.networkConfig);
    gh.lazySingleton<_i130.BackgroundService>(
        () => appCoreModule.backgroundService);
    gh.lazySingleton<_i130.SecureStorageService>(
        () => appCoreModule.secureStorageService);
    gh.lazySingleton<_i130.StorageService>(() => appCoreModule.storageService);
    gh.lazySingleton<_i130.LogService>(() => appCoreModule.logService);
    gh.lazySingleton<_i130.UrlLauncherService>(
        () => appCoreModule.urlLauncherService);
    gh.lazySingleton<_i130.ResponsiveService>(
        () => appCoreModule.responsiveService);
    gh.lazySingleton<_i130.RepositoryErrorHandler>(
        () => appCoreModule.repositoryErrorHandler);
    gh.lazySingleton<_i130.LocalNotificationService>(
        () => appCoreModule.localNotificationService);
    gh.lazySingleton<_i130.FirebaseMessagingService>(
        () => appCoreModule.firebaseMessagingService);
    await gh.lazySingletonAsync<_i130.StorageService>(
      () => sukmaModule.tbMUserStorage(),
      instanceName: 'tb_m_user',
      preResolve: true,
    );
    gh.lazySingleton<_i130.AuthenticationService>(
      () => sukmaModule.appleAuthService(),
      instanceName: 'appleAuth',
    );
    gh.lazySingleton<_i919.AuthLocalDataSource>(() =>
        _i366.AuthLocalImplDataSource(
            gh<_i130.StorageService>(instanceName: 'tb_m_user')));
    gh.lazySingleton<_i130.AuthenticationService>(
      () => sukmaModule.googleAuthService(),
      instanceName: 'googleAuth',
    );
    gh.lazySingleton<_i130.TokenProviderService>(() =>
        _i766.SessionTokenProviderService(gh<_i919.AuthLocalDataSource>()));
    gh.lazySingleton<_i130.HttpClient>(() => appCoreModule.httpClient(
          gh<_i130.NetworkConfig>(),
          gh<_i130.TokenProviderService>(),
        ));
    gh.lazySingleton<_i977.AuthRemoteDataSource>(
        () => _i15.AuthRemoteImplDataSource(
              gh<_i130.HttpClient>(),
              gh<_i130.AuthenticationService>(instanceName: 'googleAuth'),
              gh<_i130.AuthenticationService>(instanceName: 'appleAuth'),
            ));
    gh.lazySingleton<_i355.ConvertPulsaRemoteDataSource>(
        () => _i587.ConvertPulsaRemoteImplDataSource(gh<_i130.HttpClient>()));
    gh.lazySingleton<_i493.CommonRemoteDataSource>(
        () => _i871.CommonRemoteImplDataSource(gh<_i130.HttpClient>()));
    gh.lazySingleton<_i312.LandingRemoteDataSource>(
        () => _i1015.LandingRemoteImplDataSource(gh<_i130.HttpClient>()));
    gh.lazySingleton<_i647.AuthRepository>(() => _i84.AuthImplRepository(
          gh<_i787.AuthRemoteDataSource>(),
          gh<_i787.AuthLocalDataSource>(),
          gh<_i130.FirebaseMessagingService>(),
          gh<_i130.AuthenticationService>(instanceName: 'googleAuth'),
          gh<_i130.AuthenticationService>(instanceName: 'appleAuth'),
        ));
    gh.lazySingleton<_i305.LandingRepository>(
        () => _i541.LandingImplRepository(gh<_i312.LandingRemoteDataSource>()));
    gh.lazySingleton<_i342.ConvertPulsaRepository>(() =>
        _i827.ConvertPulsaImplRepository(
            gh<_i355.ConvertPulsaRemoteDataSource>()));
    gh.lazySingleton<_i852.CommonRepository>(
        () => _i564.CommonImplRepository(gh<_i493.CommonRemoteDataSource>()));
    gh.lazySingleton<_i779.GetRateUseCase>(
        () => _i779.GetRateUseCase(gh<_i305.LandingRepository>()));
    gh.lazySingleton<_i829.GetHistoryConvertUseCase>(
        () => _i829.GetHistoryConvertUseCase(gh<_i305.LandingRepository>()));
    gh.lazySingleton<_i448.GetInformationBannerUseCase>(
        () => _i448.GetInformationBannerUseCase(gh<_i305.LandingRepository>()));
    gh.lazySingleton<_i545.GetBannerUseCase>(
        () => _i545.GetBannerUseCase(gh<_i305.LandingRepository>()));
    gh.lazySingleton<_i971.CheckStatusAppUseCase>(
        () => _i971.CheckStatusAppUseCase(gh<_i305.LandingRepository>()));
    gh.lazySingleton<_i76.DeleteAccountUseCase>(
        () => _i76.DeleteAccountUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i761.LoginAppleUseCase>(
        () => _i761.LoginAppleUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i488.RefreshTokenUseCase>(
        () => _i488.RefreshTokenUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i879.GetLocalUserUseCase>(
        () => _i879.GetLocalUserUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i655.ReadTermUseCase>(
        () => _i655.ReadTermUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i939.LogoutUseCase>(
        () => _i939.LogoutUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i476.LoginGoogleUseCase>(
        () => _i476.LoginGoogleUseCase(gh<_i800.AuthRepository>()));
    gh.lazySingleton<_i1006.DeleteImageUseCase>(
        () => _i1006.DeleteImageUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i279.UploadImageUseCase>(
        () => _i279.UploadImageUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i1018.TransEvidenceUseCase>(
        () => _i1018.TransEvidenceUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i497.SaveTransKonfirmUseCase>(() =>
        _i497.SaveTransKonfirmUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i161.GetBankUseCase>(
        () => _i161.GetBankUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i139.CancelTransUseCase>(
        () => _i139.CancelTransUseCase(gh<_i342.ConvertPulsaRepository>()));
    gh.lazySingleton<_i178.DeletePhoneFavUseCase>(
        () => _i178.DeletePhoneFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i509.GetOutstandingUseCase>(
        () => _i509.GetOutstandingUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i516.SaveRekeningFavUseCase>(
        () => _i516.SaveRekeningFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i584.GetRekeningFavUseCase>(
        () => _i584.GetRekeningFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i429.GetPrefixUseCase>(
        () => _i429.GetPrefixUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i945.GetPhoneFavUseCase>(
        () => _i945.GetPhoneFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i278.SavePhoneFavUseCase>(
        () => _i278.SavePhoneFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i389.GetWaNumberUseCase>(
        () => _i389.GetWaNumberUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i780.DeleteRekeningFavUseCase>(
        () => _i780.DeleteRekeningFavUseCase(gh<_i852.CommonRepository>()));
    gh.lazySingleton<_i575.GetStatusTransaksiFailedUseCase>(() =>
        _i575.GetStatusTransaksiFailedUseCase(gh<_i852.CommonRepository>()));
    return this;
  }
}

class _$SukmaModule extends _i963.SukmaModule {}

class _$AppCoreModule extends _i493.AppCoreModule {}
