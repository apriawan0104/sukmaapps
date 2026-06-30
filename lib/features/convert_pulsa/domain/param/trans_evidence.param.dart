import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class TransEvidenceParam extends Equatable {
  const TransEvidenceParam({
    required this.noTrans,
    required this.imagePath,
    this.fileBytes,
    this.fileName,
  });

  final String noTrans;
  final String imagePath;
  final Uint8List? fileBytes;
  final String? fileName;

  @override
  List<Object?> get props => [noTrans, imagePath, fileBytes, fileName];
}
