import '../../domain/entity/entity.dart';

class EvidenceModel {
  const EvidenceModel({
    this.imageId,
  });

  final int? imageId;

  static int? _parseImageId(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  factory EvidenceModel.fromJson(Map<String, dynamic> json) {
    return EvidenceModel(
      imageId: _parseImageId(json['image_id']),
    );
  }

  EvidenceEntity toEntity() {
    return EvidenceEntity(
      imageId: imageId,
    );
  }
}
