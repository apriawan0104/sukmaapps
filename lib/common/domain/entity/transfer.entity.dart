import 'package:equatable/equatable.dart';

import 'evidence.entity.dart';

class TransferEntity extends Equatable {
  const TransferEntity({
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

  final DialupEntity? dialupCode;
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
  final EvidenceEntity? evidence;
  final String? providerName;
  final bool? cancelByAdmin;

  @override
  List<Object?> get props => [
        dialupCode,
        bucket,
        total,
        nominal,
        subtotal,
        noSending,
        rate,
        bank,
        nameCustomer,
        noRekening,
        nameRekening,
        noTrans,
        status,
        charge,
        credit,
        costPayment,
        createdAt,
        expiredAt,
        interval,
        evidence,
        providerName,
        cancelByAdmin
      ];
}

class DialupEntity extends Equatable {
  const DialupEntity({
    this.phone,
    this.sms,
  });

  final PhoneEntity? phone;
  final SmsEntity? sms;

  @override
  List<Object?> get props => [phone, sms];
}

class PhoneEntity extends Equatable {
  const PhoneEntity({
    this.active,
    this.value,
  });

  final bool? active;
  final String? value;

  @override
  List<Object?> get props => [active, value];
}

class SmsEntity extends Equatable {
  const SmsEntity({
    this.active,
    this.value,
    this.text,
  });

  final bool? active;
  final String? value;
  final String? text;

  @override
  List<Object?> get props => [active, value, text];
}
