import '../../domain/entity/entity.dart';

class SocialMediaModel {
  const SocialMediaModel({
    this.id,
    this.type,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? type;
  final String? url;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      url: json['url'] as String?,
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

  SocialMediaEntity toEntity() {
    return SocialMediaEntity(
      id: id ?? 0,
      type: type ?? '',
      url: url ?? '',
      status: status ?? false,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
