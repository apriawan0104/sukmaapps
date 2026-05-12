import '../../domain/entity/entity.dart';

class RateModel {
  const RateModel({
    this.name,
    this.maksBalance,
    this.minConvert,
    this.maksConvert,
    this.rate,
    this.providerId,
    this.isActive,
  });

  final String? name;
  final int? maksBalance;
  final int? minConvert;
  final int? maksConvert;
  final String? rate;
  final int? providerId;
  final bool? isActive;

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      name: json['name'] as String?,
      maksBalance: json['maks_balance'] as int?,
      minConvert: json['min_convert'] as int?,
      maksConvert: json['maks_convert'] as int?,
      rate: json['rate'] as String?,
      providerId: json['provider_id'] as int?,
      isActive: json['is_active'] as bool?,
    );
  }

  RateEntity toEntity() {
    return RateEntity(
      name: name,
      maksBalance: maksBalance,
      minConvert: minConvert,
      maksConvert: maksConvert,
      rate: rate,
      providerId: providerId,
      isActive: isActive,
    );
  }
}
