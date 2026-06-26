import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';

class HistoryConvertModel {
  const HistoryConvertModel({
    this.dialupCode,
    this.total,
    this.nominal,
    this.subtotal,
    this.noSending,
    this.rate,
    this.bank,
    this.nameCustomer,
    this.nameRekening,
    this.noRekening,
    this.noTrans,
    this.status,
    this.bucket,
    this.provider,
    this.charge,
    this.credit,
    this.costPayment,
    this.createdAt,
    this.interval,
    this.isHold,
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
  final String? nameRekening;
  final String? noRekening;
  final String? noTrans;
  final int? status;
  final String? bucket;
  final ProviderModel? provider;
  final int? charge;
  final int? credit;
  final int? costPayment;
  final DateTime? createdAt;
  final dynamic interval;
  final bool? isHold;
  final bool? cancelByAdmin;

  factory HistoryConvertModel.fromJson(Map<String, dynamic> json) {
    return HistoryConvertModel(
      dialupCode: json['dialup_code'] as String?,
      total: json['total'] as int?,
      nominal: json['nominal'] as int?,
      subtotal: json['subtotal'] as int?,
      noSending: json['no_sending'] as String?,
      rate: json['rate'] as String?,
      bank: json['bank'] as String?,
      nameCustomer: json['name_customer'] as String?,
      nameRekening: json['name_rekening'] as String?,
      noRekening: json['no_rekening'] as String?,
      noTrans: json['no_trans'] as String?,
      status: json['status'] as int?,
      bucket: json['bucket'] as String?,
      provider: json['provider'] != null
          ? ProviderModel.fromJson(json['provider'] as Map<String, dynamic>)
          : null,
      charge: json['charge'] as int?,
      credit: json['credit'] as int?,
      costPayment: json['cost_payment'] as int?,
      createdAt: _parseDateTime(json['created_at']),
      interval: json['interval'] as dynamic,
      isHold: json['is_hold'] as bool?,
      cancelByAdmin: json['cancel_by_admin'] as bool?,
    );
  }

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

  HistoryConvertEntity toEntity() {
    return HistoryConvertEntity(
      dialupCode: dialupCode,
      total: total,
      nominal: nominal,
      subtotal: subtotal,
      noSending: noSending,
      rate: rate,
      bank: bank,
      nameCustomer: nameCustomer,
      nameRekening: nameRekening,
      noRekening: noRekening,
      noTrans: noTrans,
      status: status,
      bucket: bucket,
      provider: provider?.toEntity(),
      charge: charge,
      credit: credit,
      costPayment: costPayment,
      createdAt: createdAt,
      interval: interval,
      isHold: isHold,
      cancelByAdmin: cancelByAdmin,
    );
  }
}
