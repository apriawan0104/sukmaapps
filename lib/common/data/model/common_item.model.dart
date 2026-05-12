import '../../domain/entity/entity.dart';

class CommonItemModel {
  const CommonItemModel({
    this.id,
  });

  final int? id;

  factory CommonItemModel.fromJson(Map<String, dynamic> json) {
    return CommonItemModel(
      id: json['id'] as int?,
    );
  }

  CommonItemEntity toEntity() {
    return CommonItemEntity(
      id: id ?? 0,
    );
  }
}
