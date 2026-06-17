class CalcNominalHelper {
  static double fromRate({required String rate, required int nominal}) {
    if (nominal <= 0) {
      return 0;
    }

    final cleanRate = rate.replaceAll('%', '').trim();
    final rateValue = double.tryParse(cleanRate) ?? 0;
    if (rateValue <= 0) {
      return 0;
    }

    final multiplier = rateValue > 1 ? rateValue / 100 : rateValue;
    return nominal * multiplier;
  }

  static int parseNominal(String nominal) {
    return int.tryParse(nominal.replaceAll('.', '')) ?? 0;
  }
}
