import '../../domain/entity/entity.dart';
import 'evidence.model.dart';

class TransferModel {
  const TransferModel({
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
  final EvidenceModel? evidence;
  final String? providerName;
  final bool? cancelByAdmin;

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      dialupCode: json['dialup_code'] as String?,
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
      createdAt: json['created_at'] as DateTime?,
      expiredAt: json['expired_at'] as DateTime?,
      interval: json['interval'] as int?,
      evidence: json['evidence'] as EvidenceModel?,
      providerName: json['provider_name'] as String?,
      cancelByAdmin: json['cancel_by_admin'] as bool?,
    );
  }

  TransferEntity toEntity() {
    return TransferEntity(
      dialupCode: dialupCode,
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
