import 'package:equatable/equatable.dart';

class DeletePhoneFavParam extends Equatable {
  const DeletePhoneFavParam({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  List<Object?> get props => [id];
}
