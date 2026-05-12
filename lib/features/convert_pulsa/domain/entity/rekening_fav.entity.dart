import 'package:equatable/equatable.dart';

class RekeningFavEntity extends Equatable {
  const RekeningFavEntity({
    required this.id,
    required this.name,
    required this.idbank,
    required this.bank,
    required this.charge,
    required this.noRekening,
    required this.bankOptional,
  });

  final int? id;
  final String? name;
  final int? idbank;
  final String? bank;
  final int? charge;
  final String? noRekening;
  final String? bankOptional;

  @override
  List<Object?> get props =>
      [id, name, idbank, bank, charge, noRekening, bankOptional];
}
