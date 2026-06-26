import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../domain/param/param.dart';
import '../../domain/usecase/cancel_trans.usecase.dart';
import '../../domain/usecase/delete_image.usecase.dart';
import '../../domain/usecase/get_bank.usecase.dart';
import '../../domain/usecase/save_trans_konfirm.usecase.dart';
import '../../domain/usecase/trans_evidence.usecase.dart';
import '../../domain/usecase/upload_image.usecase.dart';
import '../../../landing/domain/usecase/check_status_app.usecase.dart';
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
  late SaveTransKonfirmUseCase _saveTransKonfirmUseCase;
  late CheckStatusAppUseCase _checkStatusAppUseCase;
  late GetOutstandingUseCase _getOutstandingUseCase;
  late UploadImageUseCase _uploadImageUseCase;
  late DeleteImageUseCase _deleteImageUseCase;
  late CancelTransUseCase _cancelTransUseCase;
  late TransEvidenceUseCase _transEvidenceUseCase;

  void _initDependencies() {
    _savePhoneFavUseCase = getIt<SavePhoneFavUseCase>();
    _getPhoneFavUseCase = getIt<GetPhoneFavUseCase>();
    _deletePhoneFavUseCase = getIt<DeletePhoneFavUseCase>();
    _getPrefixUseCase = getIt<GetPrefixUseCase>();
    _getBankUseCase = getIt<GetBankUseCase>();
    _getRekeningFavUseCase = getIt<GetRekeningFavUseCase>();
    _deleteRekeningFavUseCase = getIt<DeleteRekeningFavUseCase>();
    _saveRekeningFavUseCase = getIt<SaveRekeningFavUseCase>();
    _saveTransKonfirmUseCase = getIt<SaveTransKonfirmUseCase>();
    _checkStatusAppUseCase = getIt<CheckStatusAppUseCase>();
    _getOutstandingUseCase = getIt<GetOutstandingUseCase>();
    _uploadImageUseCase = getIt<UploadImageUseCase>();
    _deleteImageUseCase = getIt<DeleteImageUseCase>();
    _cancelTransUseCase = getIt<CancelTransUseCase>();
    _transEvidenceUseCase = getIt<TransEvidenceUseCase>();
  }

  @override
  ConvertPulsaState build() {
    _initDependencies();
    Future.microtask(getPhoneFav);
    return const ConvertPulsaState();
  }

  String _formatPhone(String phone) {
    return phone.startsWith('0') ? phone : '0$phone';
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

        if (state.isSavePhone != true) {
          state = state.copyWith(
            choosePhone: _formatPhone(phone),
            chooseProviderName: provider,
            isProviderUnknown: false,
            savePhoneValue: const AsyncValue.data(null),
          );
          return;
        }

        state = state.copyWith(
          choosePhone: _formatPhone(phone),
          chooseProviderName: provider,
          isProviderUnknown: false,
        );

        final saveResult = await _savePhoneFavUseCase(
            SavePhoneFavParam(number: _formatPhone(phone)));

        await saveResult.fold(
          (failure) async {
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
      choosePhone: _formatPhone(phone),
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

  @override
  Future<void> saveTransKonfirm() async {
    state = state.copyWith(
      saveTransKonfirmValue: const AsyncValue.loading(),
    );

    final statusResult = await _checkStatusAppUseCase(NoParams());
    final isAppReady = statusResult.fold(
      (_) => false,
      (status) => status.serviceStatus == true && status.userStatus == true,
    );

    if (!isAppReady) {
      state = state.copyWith(
        saveTransKonfirmValue: const AsyncValue.data(null),
      );
      return;
    }

    final nominal = CalcNominalHelper.parseNominal(state.nominalPulsa ?? '');
    final providerId = state.chooseProviderName?.id ?? 0;
    final otherBank = state.chooseOtherBankName ?? '';
    final bankOptional = otherBank.isEmpty ? null : otherBank;

    final result = await _saveTransKonfirmUseCase(
      SaveTransKonfirmParam(
        phoneNum: state.choosePhone ?? '',
        bankId: state.chooseBankId ?? 0,
        noRek: state.chooseAccountNumber ?? '',
        nominal: nominal,
        nameRek: state.chooseAccountName ?? '',
        idProvider: providerId,
        bankoptional: bankOptional,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          saveTransKonfirmValue: AsyncValue.error(failure.message),
        );
      },
      (transfer) {
        state = state.copyWith(
          saveTransKonfirmValue: const AsyncValue.data(null),
          transferData: transfer,
          imagePath: '',
        );
      },
    );
  }

  @override
  Future<void> loadTransferData() async {
    if (state.transferData != null) {
      state = state.copyWith(
        transferLoadValue: AsyncValue.data(state.transferData!),
      );
      return;
    }

    state = state.copyWith(transferLoadValue: const AsyncValue.loading());

    final result = await _getOutstandingUseCase(NoParams());
    result.fold(
      (failure) {
        state = state.copyWith(
          transferLoadValue: AsyncValue.error(failure.message),
        );
      },
      (outstanding) {
        final transfer = outstanding.isNotEmpty ? outstanding.first : null;
        if (transfer == null) {
          state = state.copyWith(
            transferLoadValue:
                const AsyncValue.error('Transaksi tidak ditemukan'),
          );
          return;
        }

        state = state.copyWith(
          transferData: transfer,
          transferLoadValue: AsyncValue.data(transfer),
        );
      },
    );
  }

  @override
  Future<void> refreshTransferData() async {
    state = state.copyWith(transferLoadValue: const AsyncValue.loading());

    final result = await _getOutstandingUseCase(NoParams());
    result.fold(
      (failure) {
        state = state.copyWith(
          transferLoadValue: AsyncValue.error(failure.message),
        );
      },
      (outstanding) {
        final transfer = outstanding.isNotEmpty ? outstanding.first : null;
        if (transfer == null) {
          state = state.copyWith(
            transferLoadValue:
                const AsyncValue.error('Transaksi tidak ditemukan'),
          );
          return;
        }

        state = state.copyWith(
          transferData: transfer,
          transferLoadValue: AsyncValue.data(transfer),
        );
      },
    );
  }

  @override
  Future<void> saveImagePath(String path) async {
    final noTrans = state.transferData?.noTrans ?? '';
    if (noTrans.isEmpty) return;

    state = state.copyWith(uploadImageValue: const AsyncValue.loading());

    final result = await _uploadImageUseCase(
      UploadImageParam(noTrans: noTrans, imagePath: path),
    );

    await result.fold(
      (failure) async {
        state = state.copyWith(
          uploadImageValue: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        state = state.copyWith(
          imagePath: path,
          uploadImageValue: const AsyncValue.data(null),
        );
        await refreshTransferData();
      },
    );
  }

  @override
  Future<void> deleteImagePath() async {
    final noTrans = state.transferData?.noTrans ?? '';
    if (noTrans.isEmpty) return;

    state = state.copyWith(deleteImageValue: const AsyncValue.loading());

    final result = await _deleteImageUseCase(
      DeleteImageParam(noTrans: noTrans),
    );

    await result.fold(
      (failure) async {
        state = state.copyWith(
          deleteImageValue: AsyncValue.error(failure.message),
        );
      },
      (_) async {
        state = state.copyWith(
          imagePath: '',
          deleteImageValue: const AsyncValue.data(null),
        );
        await refreshTransferData();
      },
    );
  }

  @override
  Future<void> cancelTrans({bool? isCancel}) async {
    final noTrans = state.transferData?.noTrans ?? '';
    if (noTrans.isEmpty) return;

    state = state.copyWith(cancelTransValue: const AsyncValue.loading());

    final result = await _cancelTransUseCase(
      CancelParam(noTrans: noTrans, isCancel: isCancel),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          cancelTransValue: AsyncValue.error(failure.message),
        );
        StaticWidget.msgToast(failure.message);
      },
      (_) {
        state = state.copyWith(
          cancelTransValue: const AsyncValue.data(null),
        );
        appRouter.goNamed(
          RouteNames.detailTransaction,
          extra: DetailTransaksiArg(
            transNo: noTrans,
          ),
        );
      },
    );
  }

  @override
  Future<void> submitTransEvidence() async {
    final noTrans = state.transferData?.noTrans ?? '';
    final imagePath = state.imagePath;

    if (imagePath.isEmpty) {
      StaticWidget.msgToast(
        'Gambar belum dilampirkan, harap upload terlebih dahulu!',
      );
      return;
    }

    if (noTrans.isEmpty) return;

    state = state.copyWith(transEvidenceValue: const AsyncValue.loading());

    final result = await _transEvidenceUseCase(
      TransEvidenceParam(noTrans: noTrans, imagePath: imagePath),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          transEvidenceValue: AsyncValue.error(failure.message),
        );
        StaticWidget.msgToast(failure.message);
      },
      (_) async {
        state = state.copyWith(
          transEvidenceValue: const AsyncValue.data(null),
        );
        await ref
            .read(inAppReviewServiceProvider.notifier)
            .incrementSuccessfulTransactions();
        appRouter.goNamed(
          RouteNames.detailTransaction,
          extra: DetailTransaksiArg(
            transNo: noTrans,
          ),
        );
      },
    );
  }
}
