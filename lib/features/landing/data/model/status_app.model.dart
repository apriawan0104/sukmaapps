import '../../domain/entity/entity.dart';

class StatusAppModel {
  const StatusAppModel({
    this.serviceStatus,
    this.userStatus,
    this.providerNotActive,
    this.noWhatsapp,
    this.isHold,
  });

  final bool? serviceStatus;
  final bool? userStatus;
  final String? providerNotActive;
  final String? noWhatsapp;
  final bool? isHold;

  factory StatusAppModel.fromJson(Map<String, dynamic> json) {
    return StatusAppModel(
      serviceStatus: json['service_status'] as bool?,
      userStatus: json['user_status'] as bool?,
      providerNotActive: json['provider_not_active'] as String?,
      noWhatsapp: json['no_whatsapp'] as String?,
      isHold: json['is_hold'] as bool?,
    );
  }

  StatusAppEntity toEntity() {
    return StatusAppEntity(
      serviceStatus: serviceStatus,
      userStatus: userStatus,
      providerNotActive: providerNotActive,
      noWhatsapp: noWhatsapp,
      isHold: isHold,
    );
  }
}
