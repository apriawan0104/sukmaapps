import 'package:equatable/equatable.dart';

class DeleteRekeningFavParam extends Equatable {
  const DeleteRekeningFavParam({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  List<Object?> get props => [id];
}
