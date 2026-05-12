import 'package:equatable/equatable.dart';

class BankEntity extends Equatable {
  const BankEntity({
    required this.id,
    required this.name,
    required this.charge,
    required this.typePayment,
  });

  final int? id;
  final String? name;
  final int? charge;
  final dynamic typePayment;

  @override
  List<Object?> get props => [id, name, charge, typePayment];
}
