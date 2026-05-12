import 'package:equatable/equatable.dart';

class SaveTransKonfirmParam extends Equatable {
  const SaveTransKonfirmParam({
    required this.phoneNum,
    required this.bankId,
    required this.noRek,
    required this.nominal,
    required this.nameRek,
    required this.idProvider,
    this.bankoptional,
  });

  final String phoneNum;
  final int bankId;
  final String noRek;
  final int nominal;
  final String nameRek;
  final int idProvider;
  final String? bankoptional;

  Map<String, dynamic> toJson() => {
        'nominal': nominal,
        'id_bank': bankId,
        'no_rekening': noRek,
        'number': phoneNum,
        'name_rekening': nameRek,
        'id_provider': idProvider,
        'bank_optional': bankoptional
      };

  @override
  List<Object?> get props =>
      [phoneNum, bankId, noRek, nominal, nameRek, idProvider, bankoptional];
}
