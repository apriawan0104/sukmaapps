import 'package:equatable/equatable.dart';

import '../../../../common/common.dart';

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
