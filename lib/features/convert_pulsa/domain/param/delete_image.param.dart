import 'package:equatable/equatable.dart';

class DeleteImageParam extends Equatable {
  const DeleteImageParam({
    required this.noTrans,
  });

  final String noTrans;

  Map<String, dynamic> toQuery() => {
        'no_trans': noTrans,
      };

  @override
  List<Object?> get props => [noTrans];
}
