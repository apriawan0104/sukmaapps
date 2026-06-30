import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'transfer_picked_image.dart';

Future<TransferPickedImage?> pickTransferImage({
  ImageSource imageSource = ImageSource.gallery,
  double maxSize = 400,
  Uint8List? existingBytes,
}) async {
  try {
    Uint8List bytes;

    if (existingBytes == null) {
      final imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      if (imageFile == null) return null;

      bytes = await imageFile.readAsBytes();
      final displayName = imageFile.name.isNotEmpty
          ? imageFile.name
          : imageFile.path.split('/').last;

      if (bytes.lengthInBytes / 1024 >= maxSize) {
        log('image bigger than 400kb');

        bytes = Uint8List.fromList(
          await FlutterImageCompress.compressWithList(
            bytes,
            quality: 50,
          ),
        );

        if (bytes.lengthInBytes / 1024 >= maxSize) {
          return pickTransferImage(
            maxSize: maxSize,
            existingBytes: bytes,
          );
        }
      }

      return TransferPickedImage(
        path: imageFile.path,
        displayName: displayName,
        bytes: bytes,
      );
    }

    bytes = Uint8List.fromList(
      await FlutterImageCompress.compressWithList(
        existingBytes,
        quality: 50,
      ),
    );

    if (bytes.lengthInBytes / 1024 >= maxSize) {
      return pickTransferImage(
        maxSize: maxSize,
        existingBytes: bytes,
      );
    }

    return TransferPickedImage(
      path: '',
      displayName: 'image.jpg',
      bytes: bytes,
    );
  } catch (_) {}

  return null;
}
