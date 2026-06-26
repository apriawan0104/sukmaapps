import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../../auth/domain/entity/local_user.entity.dart';
import '../../domain/entity/entity.dart';

class LandingState extends Equatable {
  const LandingState({
    this.indexNav = 0,
    this.banner = const AsyncValue.loading(),
    this.informationBanner = const AsyncValue.loading(),
    this.rate = const AsyncValue.loading(),
    this.statusApp = const AsyncValue.loading(),
    this.historyConvert = const AsyncValue.loading(),
    this.phoneFav = const AsyncValue.loading(),
    this.rekeningFav = const AsyncValue.loading(),
    this.localUser = const AsyncValue.loading(),
    this.outstanding = const AsyncValue.loading(),
    this.statusTransaksiFailed = const AsyncValue.loading(),
  });

  final int indexNav;
  final AsyncValue<List<BannerEntity>> banner;
  final AsyncValue<List<InformationBannerEntity>> informationBanner;
  final AsyncValue<List<RateEntity>> rate;
  final AsyncValue<TransferEntity?> outstanding;
  final AsyncValue<StatusAppEntity> statusApp;
  final AsyncValue<List<HistoryConvertEntity>> historyConvert;
  final AsyncValue<List<PhoneFavEntity>> phoneFav;
  final AsyncValue<List<RekeningFavEntity>> rekeningFav;
  final AsyncValue<LocalUserEntity> localUser;
  final AsyncValue<List<StatusTransaksiEntity>> statusTransaksiFailed;

  @override
  List<Object?> get props => [
        indexNav,
        banner,
        informationBanner,
        rate,
        statusApp,
        historyConvert,
        phoneFav,
        rekeningFav,
        localUser,
        outstanding,
        statusTransaksiFailed,
      ];

  LandingState copyWith({
    int? indexNav,
    AsyncValue<List<BannerEntity>>? banner,
    AsyncValue<List<InformationBannerEntity>>? informationBanner,
    AsyncValue<List<RateEntity>>? rate,
    AsyncValue<StatusAppEntity>? statusApp,
    AsyncValue<List<HistoryConvertEntity>>? historyConvert,
    AsyncValue<List<PhoneFavEntity>>? phoneFav,
    AsyncValue<List<RekeningFavEntity>>? rekeningFav,
    AsyncValue<LocalUserEntity>? localUser,
    AsyncValue<TransferEntity?>? outstanding,
    AsyncValue<List<StatusTransaksiEntity>>? statusTransaksiFailed,
  }) {
    return LandingState(
      indexNav: indexNav ?? this.indexNav,
      banner: banner ?? this.banner,
      informationBanner: informationBanner ?? this.informationBanner,
      rate: rate ?? this.rate,
      statusApp: statusApp ?? this.statusApp,
      historyConvert: historyConvert ?? this.historyConvert,
      phoneFav: phoneFav ?? this.phoneFav,
      rekeningFav: rekeningFav ?? this.rekeningFav,
      localUser: localUser ?? this.localUser,
      outstanding: outstanding ?? this.outstanding,
      statusTransaksiFailed:
          statusTransaksiFailed ?? this.statusTransaksiFailed,
    );
  }
}
