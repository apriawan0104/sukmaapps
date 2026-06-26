import 'package:equatable/equatable.dart';

import 'convert_pulsa_access.entity.dart';

class StatusAppEntity extends Equatable {
  const StatusAppEntity({
    required this.serviceStatus,
    required this.userStatus,
    required this.providerNotActive,
    required this.noWhatsapp,
    required this.isHold,
  });

  final bool? serviceStatus;
  final bool? userStatus;
  final String? providerNotActive;
  final String? noWhatsapp;
  final bool? isHold;

  bool get canConvertPulsa => statusBlockReason == null;

  ConvertPulsaAccessResult? get statusBlockReason {
    if (serviceStatus != true) {
      return ConvertPulsaAccessResult.serviceOffline;
    }
    if (userStatus != true) {
      return ConvertPulsaAccessResult.userBlocked;
    }
    if (isHold == true) {
      return ConvertPulsaAccessResult.transactionHold;
    }
    return null;
  }

  @override
  List<Object?> get props =>
      [serviceStatus, userStatus, providerNotActive, noWhatsapp, isHold];
}
