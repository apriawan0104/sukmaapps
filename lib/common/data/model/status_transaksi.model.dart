import '../../domain/entity/entity.dart';

class StatusTransaksiModel {
  const StatusTransaksiModel({
    this.id,
    this.nameProvider,
    this.noTrans,
    this.description,
  });

  final int? id;
  final String? nameProvider;
  final String? noTrans;
  final String? description;

  factory StatusTransaksiModel.fromJson(Map<String, dynamic> json) {
    return StatusTransaksiModel(
      id: json['id'] as int?,
      nameProvider: json['name_provider'] as String?,
      noTrans: json['no_trans'] as String?,
      description: json['description'] as String?,
    );
  }

  StatusTransaksiEntity toEntity() {
    return StatusTransaksiEntity(
      id: id,
      nameProvider: nameProvider,
      noTrans: noTrans,
      description: description,
    );
  }
}
