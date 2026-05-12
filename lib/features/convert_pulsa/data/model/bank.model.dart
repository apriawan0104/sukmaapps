import '../../domain/entity/entity.dart';

class BankModel {
  const BankModel({
    this.id,
    this.name,
    this.charge,
    this.typePayment,
  });

  final int? id;
  final String? name;
  final int? charge;
  final dynamic typePayment;

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      charge: json['charge'] as int?,
      typePayment: json['type_payment'] as dynamic,
    );
  }

  BankEntity toEntity() {
    return BankEntity(
      id: id,
      name: name,
      charge: charge,
      typePayment: typePayment,
    );
  }
}
