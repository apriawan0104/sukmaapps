import 'package:equatable/equatable.dart';

class SavePhoneFavParam extends Equatable {
  const SavePhoneFavParam({
    required this.number,
  });

  final String number;

  Map<String, dynamic> toJson() => {
        'number': number,
      };

  @override
  List<Object?> get props => [number];
}
