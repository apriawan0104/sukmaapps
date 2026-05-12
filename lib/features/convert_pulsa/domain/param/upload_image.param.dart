import 'package:equatable/equatable.dart';

class UploadImageParam extends Equatable {
  const UploadImageParam({
    required this.noTrans,
    required this.imagePath,
  });

  final String noTrans;
  final String imagePath;

  Map<String, dynamic> toJson() => {
        'no_trans': noTrans,
        'file': imagePath,
      };

  @override
  List<Object?> get props => [noTrans, imagePath];
}
