import '../../domain/entity/entity.dart';

class InformationBannerModel {
  const InformationBannerModel({
    this.type,
    this.description,
  });

  final String? type;
  final String? description;

  factory InformationBannerModel.fromJson(Map<String, dynamic> json) {
    return InformationBannerModel(
      type: json['type'] as String?,
      description: json['description'] as String?,
    );
  }

  InformationBannerEntity toEntity() {
    return InformationBannerEntity(
      type: type,
      description: description,
    );
  }
}
