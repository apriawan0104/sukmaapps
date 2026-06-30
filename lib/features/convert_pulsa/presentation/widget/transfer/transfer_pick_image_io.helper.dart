import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/core.dart';
import 'transfer_picked_image.dart';

Future<TransferPickedImage?> pickTransferImage({
  ImageSource imageSource = ImageSource.gallery,
  File? existingFile,
  double maxSize = 400,
}) async {
  try {
    String imagePath = '';
    double imageSize = 0;

    if (existingFile == null) {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(
        source: imageSource,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      imagePath = imageFile?.path ?? '';
      if (imagePath.isEmpty) return null;
      imageSize = File(imagePath).readAsBytesSync().lengthInBytes / 1024;
    } else {
      imagePath = existingFile.path;
      imageSize = File(imagePath).readAsBytesSync().lengthInBytes / 1024;
    }

    if (imageSize >= maxSize) {
      log('image bigger than 400kb');

      final dir = await getTemporaryDirectory();
      final targetPath =
          '${dir.absolute.path}/temp-${UtilitiesHelper.getRandomString(15)}.jpg';
      final imageFileFile = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        targetPath,
        quality: 50,
      );

      if (imageFileFile == null) return null;

      if (await File(imageFileFile.path).length() >= maxSize * 1024) {
        return pickTransferImage(
          imageSource: imageSource,
          existingFile: File(imageFileFile.path),
        );
      }

      imagePath = imageFileFile.path;
    }

    return TransferPickedImage(
      path: imagePath,
      displayName: imagePath.split('/').last,
    );
  } catch (e) {
    if (e.toString().contains('camera_access_denied')) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  return null;
}
