import 'dart:typed_data';

class TransferPickedImage {
  const TransferPickedImage({
    required this.path,
    required this.displayName,
    this.bytes,
  });

  final String path;
  final String displayName;
  final Uint8List? bytes;
}
