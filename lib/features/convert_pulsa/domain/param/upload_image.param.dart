import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UploadImageParam extends Equatable {
  const UploadImageParam({
    required this.noTrans,
    required this.imagePath,
    this.fileBytes,
    this.fileName,
  });

  final String noTrans;
  final String imagePath;
  final Uint8List? fileBytes;
  final String? fileName;

  Map<String, dynamic> toJson() => {
        'no_trans': noTrans,
        'file': imagePath,
      };

  @override
  List<Object?> get props => [noTrans, imagePath, fileBytes, fileName];
}
