import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class TransferEvidenceImageWidget extends StatelessWidget {
  const TransferEvidenceImageWidget({
    super.key,
    required this.imageId,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final int imageId;
  final double? height;
  final double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: WebServiceConstant.imageUrl(imageId),
      height: height,
      width: width,
      fit: fit,
      placeholder: (_, __) => SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (_, __, ___) => Icon(
        Icons.broken_image_outlined,
        size: height ?? width ?? 24,
      ),
    );
  }
}
