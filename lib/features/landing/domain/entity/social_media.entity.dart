import 'package:equatable/equatable.dart';

class SocialMediaEntity extends Equatable {
  const SocialMediaEntity({
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

  @override
  List<Object?> get props => [id, type, url, status, createdAt, updatedAt];
}
