import '../../../../common/common.dart';

/// Template: VS Code snippet `ctrl` (prefix `ctrl`).
abstract class ConvertPulsaController {
  Future<void> savePhoneFav(String phone);
  Future<void> getPhoneFav();
  Future<void> deletePhoneFav(String phone);
  Future<void> choosePhone(
      {required String phone, required ProviderEntity provider});
  Future<void> isSavePhone(bool isSave);
  void resetProviderUnknown();
}
