import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
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
  });

  final int indexNav;
  final AsyncValue<List<BannerEntity>> banner;
  final AsyncValue<List<InformationBannerEntity>> informationBanner;
  final AsyncValue<List<RateEntity>> rate;
  final AsyncValue<StatusAppEntity> statusApp;
  final AsyncValue<List<HistoryConvertEntity>> historyConvert;
  final AsyncValue<List<PhoneFavEntity>> phoneFav;
  final AsyncValue<List<RekeningFavEntity>> rekeningFav;

  @override
  List<Object?> get props => [
        indexNav,
        banner,
        informationBanner,
        rate,
        statusApp,
        historyConvert,
        phoneFav,
        rekeningFav
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
    );
  }
}
