import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class TransferFileImageWidget extends StatelessWidget {
  const TransferFileImageWidget({
    super.key,
    required this.imagePath,
    this.imageBytes,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final String imagePath;
  final Uint8List? imageBytes;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imagePath),
      height: height,
      width: width,
      fit: fit,
    );
  }
}
