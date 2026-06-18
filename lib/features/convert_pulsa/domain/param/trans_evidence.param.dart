import 'package:equatable/equatable.dart';

class TransEvidenceParam extends Equatable {
  const TransEvidenceParam({
    required this.noTrans,
    required this.imagePath,
  });

  final String noTrans;
  final String imagePath;

  @override
  List<Object?> get props => [noTrans, imagePath];
}
