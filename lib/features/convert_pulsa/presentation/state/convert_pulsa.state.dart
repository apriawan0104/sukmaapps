import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';

class ConvertPulsaState extends Equatable {
  const ConvertPulsaState(
      {this.phoneFav = const AsyncValue<List<PhoneFavEntity>>.loading(),
      this.choosePhone});

  final AsyncValue<List<PhoneFavEntity>>? phoneFav;
  final String? choosePhone;

  @override
  List<Object?> get props => [phoneFav, choosePhone];

  ConvertPulsaState copyWith({
    AsyncValue<List<PhoneFavEntity>>? phoneFav,
    String? choosePhone,
  }) {
    return ConvertPulsaState(
      phoneFav: phoneFav ?? this.phoneFav,
      choosePhone: choosePhone ?? this.choosePhone,
    );
  }
}
