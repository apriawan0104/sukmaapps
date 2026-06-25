import '../../domain/entity/entity.dart';

class ProviderModel {
  const ProviderModel({
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

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      maksBalance: json['maks_balance'] as int?,
      maksConvert: json['maks_convert'] as int?,
      minConvert: json['min_convert'] as int?,
      rate: json['rate'] as String?,
      formatTransfer: json['format_transfer'] as String?,
      status: json['status'] as bool?,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
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

  ProviderEntity toEntity() {
    return ProviderEntity(
      id: id,
      name: name,
      maksBalance: maksBalance,
      maksConvert: maksConvert,
      minConvert: minConvert,
      rate: rate,
      formatTransfer: formatTransfer,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
