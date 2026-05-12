import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props =>
      [serviceStatus, userStatus, providerNotActive, noWhatsapp, isHold];
}
