import '../../domain/entity/entity.dart';

class PhoneFavModel {
  const PhoneFavModel({
    this.id,
    this.number,
    this.provider,
    this.rate,
    this.providerId,
    this.maksConvert,
    this.minConvert,
  });

  final int? id;
  final String? number;
  final String? provider;
  final String? rate;
  final int? providerId;
  final int? maksConvert;
  final int? minConvert;

  factory PhoneFavModel.fromJson(Map<String, dynamic> json) {
    return PhoneFavModel(
      id: json['id'] as int?,
      number: json['number'] as String?,
      provider: json['provider'] as String?,
      rate: json['rate'] as String?,
      providerId: json['provider_id'] as int?,
      maksConvert: json['maks_convert'] as int?,
      minConvert: json['min_convert'] as int?,
    );
  }

  PhoneFavEntity toEntity() {
    return PhoneFavEntity(
      id: id,
      number: number,
      provider: provider,
      rate: rate,
      providerId: providerId,
      maksConvert: maksConvert,
      minConvert: minConvert,
    );
  }
}
