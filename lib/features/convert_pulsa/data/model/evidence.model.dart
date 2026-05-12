import '../../domain/entity/entity.dart';

class EvidenceModel {
  const EvidenceModel({
    this.imageId,
  });

  final int? imageId;

  factory EvidenceModel.fromJson(Map<String, dynamic> json) {
    return EvidenceModel(
      imageId: json['image_id'] as int?,
    );
  }

  EvidenceEntity toEntity() {
    return EvidenceEntity(
      imageId: imageId,
    );
  }
}
