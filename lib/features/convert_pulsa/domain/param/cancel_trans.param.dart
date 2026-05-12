import 'package:equatable/equatable.dart';

class CancelParam extends Equatable {
  const CancelParam({
    required this.noTrans,
    this.isCancel,
  });

  final String noTrans;
  final bool? isCancel;

  Map<String, dynamic> toJson() => {
        'is_cancel': isCancel,
      };

  Map<String, dynamic> toQuery() => {
        'no_trans': noTrans,
      };

  @override
  List<Object?> get props => [noTrans, isCancel];
}
