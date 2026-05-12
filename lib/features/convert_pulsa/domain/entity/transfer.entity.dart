import 'package:equatable/equatable.dart';

import 'evidence.entity.dart';

class TransferEntity extends Equatable {
  const TransferEntity({
    this.dialupCode,
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

  final String? dialupCode;
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
