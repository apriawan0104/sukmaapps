import 'package:flutter_dotenv/flutter_dotenv.dart';

class WebServiceConstant {
  static const String rate = 'rate';
  static const String banner = 'banner';
  static const String informationBanner = 'information';
  static const String prefix = 'prefix';
  static const String number = 'customer/number';
  static const String rekening = 'customer/rekening';
  static const String bank = 'bank';
  static const String transOpen = 'transaction/open';
  static const String transGet = 'transaction/get';
  static const String authRegister = 'auth/register';
  static const String acceptTerm = 'customer/policy';
  static const String cancelTrans = 'transaction/delete';
  static const String transEvidence = 'transaction/evidence';
  static const String uploadImage = 'transaction/evidence/upload';
  static const String deleteImage = 'transaction/evidence/delete';
  static const String transHistory = 'transaction/history';
  static const String statusApp = 'status/apps';
  static const String accountDelete = 'auth/account/delete';
  static const String waNumber = 'status/apps';
  static const String statusTransaksiFailed = 'transaction/onhold';
  static String imageUrl(int imageId) => '${dotenv.env['imageUrl']}/image/$imageId';
}
