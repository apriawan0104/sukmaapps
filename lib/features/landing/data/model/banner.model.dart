import '../../domain/entity/entity.dart';

class BannerModel {
  const BannerModel({
    this.id,
    this.imageId,
    this.title,
    this.url,
    this.urlAction,
  });

  final int? id;
  final int? imageId;
  final String? title;
  final String? url;
  final String? urlAction;

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int?,
      imageId: json['image_id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      urlAction: json['url_action'] as String?,
    );
  }

  BannerEntity toEntity() {
    return BannerEntity(
      id: id,
      imageId: imageId,
      title: title,
      url: url,
      urlAction: urlAction,
    );
  }
}
