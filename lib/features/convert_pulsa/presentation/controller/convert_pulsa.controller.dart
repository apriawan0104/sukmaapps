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
  Future<void> calcNominal(String nominal);
  void saveNominal(String nominalPulsa);
  Future<void> getListBank();
  Future<void> getRekeningFav();
  Future<void> deleteRekeningFav(String id);
  Future<void> chooseRekening(
      {required int bankId,
      required String bankName,
      required int bankCharge,
      String? otherBankName,
      required String accountNumber,
      required String accountName});
  Future<void> isSaveRekening(bool isSave);
  Future<void> saveRekening({
    required int bankId,
    required String bankName,
    required int bankCharge,
    String? otherBankName,
    required String accountNumber,
    required String accountName,
  });

  void saveNominalRekening(String nominalRekening);
}
