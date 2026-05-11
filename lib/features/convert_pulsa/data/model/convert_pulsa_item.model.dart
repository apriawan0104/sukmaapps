import '../../domain/entity/entity.dart';

/// Template: VS Code snippet `mod` (prefix `mod`).
class ConvertPulsaItemModel {
  const ConvertPulsaItemModel({
    this.id,
  });

  final int? id;

  factory ConvertPulsaItemModel.fromJson(Map<String, dynamic> json) {
    return ConvertPulsaItemModel(
      id: json['id'] as int?,
    );
  }

  ConvertPulsaItemEntity toEntity() {
    return ConvertPulsaItemEntity(
      id: id ?? 0,
    );
  }
}
