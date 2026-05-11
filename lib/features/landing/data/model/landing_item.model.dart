import '../../domain/entity/entity.dart';

/// Template: VS Code snippet `mod` (prefix `mod`).
class LandingItemModel {
  const LandingItemModel({
    this.id,
  });

  final int? id;

  factory LandingItemModel.fromJson(Map<String, dynamic> json) {
    return LandingItemModel(
      id: json['id'] as int?,
    );
  }

  LandingItemEntity toEntity() {
    return LandingItemEntity(
      id: id ?? 0,
    );
  }
}
