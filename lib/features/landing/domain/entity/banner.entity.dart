import 'package:equatable/equatable.dart';

/// Template: VS Code snippet `ent` (prefix `ent`).
class BannerEntity extends Equatable {
  const BannerEntity({
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

  @override
  List<Object?> get props => [id, imageId, title, url, urlAction];
}
