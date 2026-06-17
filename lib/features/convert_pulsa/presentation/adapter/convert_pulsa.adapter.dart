import 'package:riverpod_annotation/riverpod_annotation.dart' hide AsyncValue;
import 'package:app_core/app_core.dart';
import '../../../../common/common.dart';
import '../../../../config/config.dart';
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

  void _initDependencies() {
    _savePhoneFavUseCase = getIt<SavePhoneFavUseCase>();
    _getPhoneFavUseCase = getIt<GetPhoneFavUseCase>();
    _deletePhoneFavUseCase = getIt<DeletePhoneFavUseCase>();
    _getPrefixUseCase = getIt<GetPrefixUseCase>();
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
}
