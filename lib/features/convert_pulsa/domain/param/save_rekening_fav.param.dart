import 'package:equatable/equatable.dart';

class SaveRekeningFavParam extends Equatable {
  const SaveRekeningFavParam({
    required this.nameRek,
    required this.noRek,
    required this.idBank,
  });

  final String nameRek;
  final String noRek;
  final String idBank;

  Map<String, dynamic> toJson() => {
        "name": nameRek,
        "no_rekening": noRek,
        "id_bank": idBank,
      };

  @override
  List<Object?> get props => [nameRek, noRek, idBank];
}
