import '../../domain/entity/entity.dart';

class RekeningFavModel {
  const RekeningFavModel({
    this.id,
    this.name,
    this.idbank,
    this.bank,
    this.charge,
    this.noRekening,
    this.bankOptional,
  });

  final int? id;
  final String? name;
  final int? idbank;
  final String? bank;
  final int? charge;
  final String? noRekening;
  final String? bankOptional;

  factory RekeningFavModel.fromJson(Map<String, dynamic> json) {
    return RekeningFavModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      idbank: json['idbank'] as int?,
      bank: json['bank'] as String?,
      charge: json['charge'] as int?,
      noRekening: json['no_rekening'] as String?,
      bankOptional: json['bank_optional'] as String?,
    );
  }

  RekeningFavEntity toEntity() {
    return RekeningFavEntity(
      id: id,
      name: name,
      idbank: idbank,
      bank: bank,
      charge: charge,
      noRekening: noRekening,
      bankOptional: bankOptional,
    );
  }
}
