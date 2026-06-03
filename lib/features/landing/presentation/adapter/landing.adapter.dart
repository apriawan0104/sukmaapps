import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sukmaapps/common/domain/entity/phone_fav.entity.dart';
import 'package:sukmaapps/common/domain/entity/rekening_fav.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/banner.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/history_convert.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/information_banner.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/rate.entity.dart';
import 'package:sukmaapps/features/landing/domain/entity/status_app.entity.dart';
import '../controller/landing.controller.dart';
import '../state/landing.state.dart';
part 'landing.adapter.g.dart';

@riverpod
class LandingRiverpodAdapter extends _$LandingRiverpodAdapter
    implements LandingController {
  @override
  LandingState build() {
    _initDependencies();
    return const LandingState();
  }

  void _initDependencies() {}

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
  Future<List<BannerEntity>> getBanner() {
    // TODO: implement getBanner
    throw UnimplementedError();
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
}
