import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../domain/usecase/get_bank.usecase.dart';
import '../controller/convert_pulsa.controller.dart';
import '../state/convert_pulsa.state.dart';
part 'convert_pulsa.adapter.g.dart';

@riverpod
class ConvertPulsaRiverpodAdapter extends _$ConvertPulsaRiverpodAdapter
    implements ConvertPulsaController {
  late SavePhoneFavUseCase _savePhoneFavUseCase;
  late GetPhoneFavUseCase _getPhoneFavUseCase;
  late DeletePhoneFavUseCase _deletePhoneFavUseCase;
  late GetPrefixUseCase _getPrefixUseCase;
  late GetBankUseCase _getBankUseCase;
  late GetRekeningFavUseCase _getRekeningFavUseCase;
  late DeleteRekeningFavUseCase _deleteRekeningFavUseCase;
  late SaveRekeningFavUseCase _saveRekeningFavUseCase;

  void _initDependencies() {
    _savePhoneFavUseCase = getIt<SavePhoneFavUseCase>();
    _getPhoneFavUseCase = getIt<GetPhoneFavUseCase>();
    _deletePhoneFavUseCase = getIt<DeletePhoneFavUseCase>();
    _getPrefixUseCase = getIt<GetPrefixUseCase>();
    _getBankUseCase = getIt<GetBankUseCase>();
    _getRekeningFavUseCase = getIt<GetRekeningFavUseCase>();
    _deleteRekeningFavUseCase = getIt<DeleteRekeningFavUseCase>();
    _saveRekeningFavUseCase = getIt<SaveRekeningFavUseCase>();
  }

  @override
  ConvertPulsaState build() {
    _initDependencies();
    Future.microtask(getPhoneFav);
    return const ConvertPulsaState();
  }

  @override
  Future<void> savePhoneFav(String phone) async {
    state = state.copyWith(
      savePhoneValue: const AsyncValue.loading(),
      isProviderUnknown: false,
    );

    final result = await _getPrefixUseCase(GetPrefixParam(number: phone));

    await result.fold(
      (failure) async {
        state = state.copyWith(
          savePhoneValue: const AsyncValue.data(null),
          isProviderUnknown: true,
        );
      },
      (prefix) async {
        final provider = prefix.provider;
        final providerName = provider?.name ?? '';
        if (provider == null || providerName.isEmpty) {
          state = state.copyWith(
            savePhoneValue: const AsyncValue.data(null),
            isProviderUnknown: true,
          );
          return;
        }

        state = state.copyWith(
          choosePhone: phone,
          chooseProviderName: provider,
          isProviderUnknown: false,
        );

        if (state.isSavePhone != true) {
          state = state.copyWith(
            savePhoneValue: const AsyncValue.data(null),
          );
          return;
        }

        final saveResult =
            await _savePhoneFavUseCase(SavePhoneFavParam(number: phone));
        saveResult.fold(
          (failure) {
            state = state.copyWith(
              savePhoneValue: AsyncValue.error(failure.message),
            );
          },
          (_) async {
            await getPhoneFav();
            state = state.copyWith(
              savePhoneValue: const AsyncValue.data(null),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> getPhoneFav() async {
    final result = await _getPhoneFavUseCase(NoParams());
    state = state.copyWith(
      phoneFavValue: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<void> deletePhoneFav(String id) async {
    final result = await _deletePhoneFavUseCase(DeletePhoneFavParam(id: id));
    result.fold(
      (failure) {
        state = state.copyWith(
          phoneFavValue: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        await getPhoneFav();
      },
    );
  }

  @override
  Future<void> choosePhone(
      {required String phone, required ProviderEntity provider}) async {
    state = state.copyWith(
      choosePhone: phone,
      chooseProviderName: provider,
    );
  }

  @override
  Future<void> isSavePhone(bool isSave) async {
    state = state.copyWith(
      isSavePhone: isSave,
    );
  }

  @override
  void resetProviderUnknown() {
    state = state.copyWith(isProviderUnknown: false);
  }

  @override
  Future<void> calcNominal(String nominal) async {
    final rate = state.chooseProviderName?.rate ?? '';
    final parsedNominal = CalcNominalHelper.parseNominal(nominal);
    final currentValue = state.calcNominalValue;

    state = state.copyWith(
      calcNominalValue: currentValue?.hasValue == true
          ? currentValue!.copyWithLoading()
          : const AsyncValue.loading(),
    );

    await Future<void>.delayed(Duration.zero);

    if (parsedNominal <= 0) {
      state = state.copyWith(
        calcNominalValue: const AsyncValue.data(0),
      );
      return;
    }

    final credit = CalcNominalHelper.fromRate(
      rate: rate,
      nominal: parsedNominal,
    );

    state = state.copyWith(
      calcNominalValue: AsyncValue.data(credit),
    );
  }

  @override
  void saveNominal(String nominalPulsa) {
    state = state.copyWith(nominalPulsa: nominalPulsa);
  }

  @override
  Future<void> getListBank() async {
    final result = await _getBankUseCase(NoParams());
    state = state.copyWith(
      bankListValue: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<void> getRekeningFav() async {
    final result = await _getRekeningFavUseCase(NoParams());
    state = state.copyWith(
      rekeningFavValue: result.fold(
        (failure) => AsyncValue.error(failure.message),
        AsyncValue.data,
      ),
    );
  }

  @override
  Future<void> deleteRekeningFav(String id) async {
    final result =
        await _deleteRekeningFavUseCase(DeleteRekeningFavParam(id: id));
    result.fold(
      (failure) {
        state =
            state.copyWith(rekeningFavValue: AsyncValue.error(failure.message));
      },
      (_) async {
        await getRekeningFav();
      },
    );
  }

  @override
  Future<void> chooseRekening(
      {required int bankId,
      required String bankName,
      required int bankCharge,
      String? otherBankName,
      required String accountNumber,
      required String accountName}) async {
    state = state.copyWith(
      chooseBankId: bankId,
      chooseBankName: bankName,
      chooseBankCharge: bankCharge,
      chooseOtherBankName: otherBankName,
      chooseAccountNumber: accountNumber,
      chooseAccountName: accountName,
    );
  }

  @override
  Future<void> isSaveRekening(bool isSave) async {
    state = state.copyWith(isSaveRekening: isSave);
  }

  @override
  Future<void> saveRekening({
    required int bankId,
    required String bankName,
    required int bankCharge,
    String? otherBankName,
    required String accountNumber,
    required String accountName,
  }) async {
    state = state.copyWith(
      saveRekeningValue: const AsyncValue.loading(),
    );

    state = state.copyWith(
      chooseBankId: bankId,
      chooseBankName: bankName,
      chooseBankCharge: bankCharge,
      chooseOtherBankName: otherBankName,
      chooseAccountNumber: accountNumber,
      chooseAccountName: accountName,
    );

    if (state.isSaveRekening != true) {
      state = state.copyWith(
        saveRekeningValue: const AsyncValue.data(null),
      );
      return;
    }

    final saveResult = await _saveRekeningFavUseCase(
      SaveRekeningFavParam(
        name: accountName,
        noRek: accountNumber,
        idBank: bankId.toString(),
      ),
    );

    saveResult.fold(
      (failure) {
        state = state.copyWith(
          saveRekeningValue: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        await getRekeningFav();
        state = state.copyWith(
          saveRekeningValue: const AsyncValue.data(null),
        );
      },
    );
  }

  @override
  void saveNominalRekening(String nominalRekening) {
    state = state.copyWith(nominalPulsa: nominalRekening);
  }
}
