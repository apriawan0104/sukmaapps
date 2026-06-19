import 'package:equatable/equatable.dart';

class SaveRekeningFavParam extends Equatable {
  const SaveRekeningFavParam({
    required this.name,
    required this.noRek,
    required this.idBank,
    this.otherBank,
  });

  final String name;
  final String noRek;
  final String idBank;
  final String? otherBank;

  Map<String, dynamic> toJson() => {
        'name': name,
        'no_rekening': noRek,
        'id_bank': idBank,
        if (otherBank != null) 'bank_optional': otherBank,
      };

  @override
  List<Object?> get props => [name, noRek, idBank, otherBank];
}
