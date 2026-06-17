import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';

class ConvertPulsaState extends Equatable {
  const ConvertPulsaState({
    this.phoneFavValue = const AsyncValue<List<PhoneFavEntity>>.loading(),
    this.choosePhone,
    this.chooseProviderName,
    this.isSavePhone = false,
    this.savePhoneValue = const AsyncValue.data(null),
    this.isProviderUnknown = false,
    this.nominalPulsa,
    this.calcNominalValue = const AsyncValue.data(0),
  });

  final AsyncValue<List<PhoneFavEntity>>? phoneFavValue;
  final String? choosePhone;
  final ProviderEntity? chooseProviderName;
  final bool? isSavePhone;
  final AsyncValue<void>? savePhoneValue;
  final bool? isProviderUnknown;
  final String? nominalPulsa;
  final AsyncValue<double>? calcNominalValue;

  @override
  List<Object?> get props => [
        phoneFavValue,
        choosePhone,
        chooseProviderName,
        isSavePhone,
        savePhoneValue,
        isProviderUnknown,
        nominalPulsa,
        calcNominalValue,
      ];

  ConvertPulsaState copyWith({
    AsyncValue<List<PhoneFavEntity>>? phoneFavValue,
    String? choosePhone,
    ProviderEntity? chooseProviderName,
    bool? isSavePhone,
    AsyncValue<void>? savePhoneValue,
    bool? isProviderUnknown,
    String? nominalPulsa,
    AsyncValue<double>? calcNominalValue,
  }) {
    return ConvertPulsaState(
      phoneFavValue: phoneFavValue ?? this.phoneFavValue,
      choosePhone: choosePhone ?? this.choosePhone,
      chooseProviderName: chooseProviderName ?? this.chooseProviderName,
      isSavePhone: isSavePhone ?? this.isSavePhone,
      savePhoneValue: savePhoneValue ?? this.savePhoneValue,
      isProviderUnknown: isProviderUnknown ?? this.isProviderUnknown,
      nominalPulsa: nominalPulsa ?? this.nominalPulsa,
      calcNominalValue: calcNominalValue ?? this.calcNominalValue,
    );
  }
}
