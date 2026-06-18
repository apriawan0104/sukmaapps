import 'package:equatable/equatable.dart';
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';

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
    this.bankListValue = const AsyncValue<List<BankEntity>>.loading(),
    this.rekeningFavValue = const AsyncValue<List<RekeningFavEntity>>.loading(),
    this.chooseBankId,
    this.chooseBankName,
    this.chooseBankCharge,
    this.chooseOtherBankName,
    this.chooseAccountNumber,
    this.chooseAccountName,
    this.isSaveRekening = false,
    this.saveRekeningValue = const AsyncValue.data(null),
    this.saveTransKonfirmValue = const AsyncValue.data(null),
    this.transferData,
  });

  final AsyncValue<List<PhoneFavEntity>>? phoneFavValue;
  final String? choosePhone;
  final ProviderEntity? chooseProviderName;
  final bool? isSavePhone;
  final AsyncValue<void>? savePhoneValue;
  final bool? isProviderUnknown;
  final String? nominalPulsa;
  final AsyncValue<double>? calcNominalValue;
  final AsyncValue<List<BankEntity>>? bankListValue;
  final AsyncValue<List<RekeningFavEntity>>? rekeningFavValue;
  final int? chooseBankId;
  final String? chooseBankName;
  final int? chooseBankCharge;
  final String? chooseOtherBankName;
  final String? chooseAccountNumber;
  final String? chooseAccountName;
  final bool? isSaveRekening;
  final AsyncValue<void>? saveRekeningValue;
  final AsyncValue<void>? saveTransKonfirmValue;
  final TransferEntity? transferData;
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
        bankListValue,
        rekeningFavValue,
        chooseBankId,
        chooseBankName,
        chooseBankCharge,
        chooseOtherBankName,
        chooseAccountNumber,
        chooseAccountName,
        isSaveRekening,
        saveRekeningValue,
        saveTransKonfirmValue,
        transferData,
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
    AsyncValue<List<BankEntity>>? bankListValue,
    AsyncValue<List<RekeningFavEntity>>? rekeningFavValue,
    int? chooseBankId,
    String? chooseBankName,
    int? chooseBankCharge,
    String? chooseOtherBankName,
    String? chooseAccountNumber,
    String? chooseAccountName,
    bool? isSaveRekening,
    AsyncValue<void>? saveRekeningValue,
    AsyncValue<void>? saveTransKonfirmValue,
    TransferEntity? transferData,
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
      bankListValue: bankListValue ?? this.bankListValue,
      rekeningFavValue: rekeningFavValue ?? this.rekeningFavValue,
      chooseBankId: chooseBankId ?? this.chooseBankId,
      chooseBankName: chooseBankName ?? this.chooseBankName,
      chooseBankCharge: chooseBankCharge ?? this.chooseBankCharge,
      chooseOtherBankName: chooseOtherBankName ?? this.chooseOtherBankName,
      chooseAccountNumber: chooseAccountNumber ?? this.chooseAccountNumber,
      chooseAccountName: chooseAccountName ?? this.chooseAccountName,
      isSaveRekening: isSaveRekening ?? this.isSaveRekening,
      saveRekeningValue: saveRekeningValue ?? this.saveRekeningValue,
      saveTransKonfirmValue:
          saveTransKonfirmValue ?? this.saveTransKonfirmValue,
      transferData: transferData ?? this.transferData,
    );
  }
}
