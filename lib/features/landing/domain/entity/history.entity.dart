import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  const HistoryEntity({
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
  final ProviderEntity? provider;
  final int? charge;
  final int? credit;
  final int? costPayment;
  final DateTime? createdAt;
  final dynamic interval;
  final bool? isHold;
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
        nameRekening,
        noRekening,
        noTrans,
        status,
        bucket,
        provider,
        charge,
        credit,
        costPayment,
        createdAt,
        interval,
        isHold,
        cancelByAdmin
      ];
}

class ProviderEntity extends Equatable {
  const ProviderEntity({
    this.id,
    this.name,
    this.maksBalance,
    this.maksConvert,
    this.minConvert,
    this.rate,
    this.formatTransfer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? maksBalance;
  final int? maksConvert;
  final int? minConvert;
  final String? rate;
  final String? formatTransfer;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        maksBalance,
        maksConvert,
        minConvert,
        rate,
        formatTransfer,
        status,
        createdAt,
        updatedAt
      ];
}
