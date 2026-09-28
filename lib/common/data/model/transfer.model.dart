import '../../domain/entity/entity.dart';
import 'evidence.model.dart';

class TransferModel {
  const TransferModel({
    this.dialupCode,
    this.bucket,
    this.total,
    this.nominal,
    this.subtotal,
    this.noSending,
    this.rate,
    this.bank,
    this.nameCustomer,
    this.noRekening,
    this.nameRekening,
    this.noTrans,
    this.status,
    this.charge,
    this.credit,
    this.costPayment,
    this.createdAt,
    this.expiredAt,
    this.interval,
    this.evidence,
    this.providerName,
    this.cancelByAdmin,
  });

  final DialupModel? dialupCode;
  final String? bucket;
  final int? total;
  final int? nominal;
  final int? subtotal;
  final String? noSending;
  final String? rate;
  final String? bank;
  final String? nameCustomer;
  final String? noRekening;
  final String? nameRekening;
  final String? noTrans;
  final int? status;
  final int? charge;
  final int? credit;
  final int? costPayment;
  final DateTime? createdAt;
  final DateTime? expiredAt;
  final int? interval;
  final EvidenceModel? evidence;
  final String? providerName;
  final bool? cancelByAdmin;

  static DateTime? _parseDateTime(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      dialupCode: json['dialup'] != null
          ? DialupModel.fromJson(json['dialup'] as Map<String, dynamic>)
          : null,
      bucket: json['bucket'] as String?,
      total: json['total'] as int?,
      nominal: json['nominal'] as int?,
      subtotal: json['subtotal'] as int?,
      noSending: json['no_sending'] as String?,
      rate: json['rate'] as String?,
      bank: json['bank'] as String?,
      nameCustomer: json['name_customer'] as String?,
      noRekening: json['no_rekening'] as String?,
      nameRekening: json['name_rekening'] as String?,
      noTrans: json['no_trans'] as String?,
      status: json['status'] as int?,
      charge: json['charge'] as int?,
      credit: json['credit'] as int?,
      costPayment: json['cost_payment'] as int?,
      createdAt: _parseDateTime(json['created_at']),
      expiredAt: _parseDateTime(json['expired_at']),
      interval: json['interval'] as int?,
      evidence: json['evidence'] != null
          ? EvidenceModel.fromJson(json['evidence'] as Map<String, dynamic>)
          : null,
      providerName: json['provider_name'] as String?,
      cancelByAdmin: json['cancel_by_admin'] as bool?,
    );
  }

  TransferEntity toEntity() {
    return TransferEntity(
      dialupCode: dialupCode?.toEntity(),
      bucket: bucket,
      total: total,
      nominal: nominal,
      subtotal: subtotal,
      noSending: noSending,
      rate: rate,
      bank: bank,
      nameCustomer: nameCustomer,
      noRekening: noRekening,
      nameRekening: nameRekening,
      noTrans: noTrans,
      status: status,
      charge: charge,
      credit: credit,
      costPayment: costPayment,
      createdAt: createdAt,
      expiredAt: expiredAt,
      interval: interval,
      evidence: evidence?.toEntity(),
      providerName: providerName,
      cancelByAdmin: cancelByAdmin,
    );
  }
}

class DialupModel {
  const DialupModel({
    this.phone,
    this.sms,
  });

  final PhoneModel? phone;
  final SmsModel? sms;

  factory DialupModel.fromJson(Map<String, dynamic> json) {
    return DialupModel(
      phone: json['phone'] != null
          ? PhoneModel.fromJson(json['phone'] as Map<String, dynamic>)
          : null,
      sms: json['sms'] != null
          ? SmsModel.fromJson(json['sms'] as Map<String, dynamic>)
          : null,
    );
  }

  DialupEntity toEntity() {
    return DialupEntity(
      phone: phone?.toEntity(),
      sms: sms?.toEntity(),
    );
  }
}

class PhoneModel {
  const PhoneModel({
    this.active,
    this.value,
  });

  final bool? active;
  final String? value;

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      active: json['active'] as bool?,
      value: json['value'] as String?,
    );
  }

  PhoneEntity toEntity() {
    return PhoneEntity(
      active: active,
      value: value,
    );
  }
}

class SmsModel {
  const SmsModel({
    this.active,
    this.value,
    this.text,
  });

  final bool? active;
  final String? value;
  final String? text;

  factory SmsModel.fromJson(Map<String, dynamic> json) {
    return SmsModel(
      active: json['active'] as bool?,
      value: json['value'] as String?,
      text: json['text'] as String?,
    );
  }

  SmsEntity toEntity() {
    return SmsEntity(
      active: active,
      value: value,
      text: text,
    );
  }
}
