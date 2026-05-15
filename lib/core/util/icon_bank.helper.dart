import '../core.dart';

class IconBankHelper {
  IconBankHelper(this.nameBank);
  final String nameBank;

  String getIconBank() {
    if (nameBank.toLowerCase() == 'bca') {
      return IconPaymentConstant.bca;
    }
    if (nameBank.toLowerCase() == 'bni') {
      return IconPaymentConstant.bni;
    }
    if (nameBank.toLowerCase() == 'bri') {
      return IconPaymentConstant.bri;
    }
    if (nameBank.toLowerCase() == 'dana') {
      return IconPaymentConstant.dana;
    }
    if (nameBank.toLowerCase() == 'gopay') {
      return IconPaymentConstant.gopay;
    }
    if (nameBank.toLowerCase() == 'isaku') {
      return IconPaymentConstant.isaku;
    }
    if (nameBank.toLowerCase() == 'linkaja') {
      return IconPaymentConstant.linkaja;
    }
    if (nameBank.toLowerCase() == 'mandiri') {
      return IconPaymentConstant.mandiri;
    }
    if (nameBank.toLowerCase() == 'ovo') {
      return IconPaymentConstant.ovo;
    }
    if (nameBank.toLowerCase() == 'sakuku') {
      return IconPaymentConstant.sakuku;
    }
    if (nameBank.toLowerCase() == 'isaku') {
      return IconPaymentConstant.isaku;
    }
    if (nameBank.toLowerCase() == 'shopeepay') {
      return IconPaymentConstant.shopeepay;
    }
    if (nameBank.toLowerCase() == 'sea bank') {
      return IconPaymentConstant.seabank;
    }
    return IconPaymentConstant.otherBank;
  }
}
