import 'dart:developer';
import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../adapter/convert_pulsa.adapter.dart';

class TransferHelperWidget {
  static Future<void> uploadImage({
    required BuildContext context,
    required WidgetRef ref,
    required void Function(File? file) onCompleted,
  }) async {
    final item = ColoredBox(
      color: Colors.white,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: UITextPrimaryWidget(
              title: 'Upload Bukti Transfer',
              fontSize: 14.sp,
              color: AppColor.blackMassive,
              fontWeight: FontWeight.w700,
              align: TextAlign.start,
            ),
          ),
          Divider(height: 9.h, color: const Color(0xFFE7E8F3)),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.w,
              bottom: 50.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    final file =
                        await pickImage(imageSource: ImageSource.camera);
                    onCompleted(file);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: AppColor.blackMassive,
                        size: 40.w,
                      ),
                      SizedBox(height: 10.w),
                      UITextPrimaryWidget(
                        title: 'Camera',
                        fontSize: 12.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final file =
                        await pickImage(imageSource: ImageSource.gallery);
                    onCompleted(file);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.image_rounded,
                        color: AppColor.blackMassive,
                        size: 40.w,
                      ),
                      SizedBox(height: 10.w),
                      UITextPrimaryWidget(
                        title: 'Gallery',
                        fontSize: 12.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    await StaticWidget.modalBottomWidget(
      context: context,
      widget: item,
    );
  }

  static Future<void> cancelTransaction({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final item = ColoredBox(
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SvgPicture.asset(
                  IconSharedConstant.cancelTrans,
                  width: 160.w,
                  height: 160.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: UITextPrimaryWidget(
                    title: 'Batalkan Transaksi?',
                    fontSize: 14.sp,
                    color: AppColor.blackMassive,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ),
                Text(
                  'Transaksi yang sudah dibatalkan akan terhapus. Kamu perlu membuatnya kembali jika diperlukan',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColor.blackFair,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, reff, child) {
              final ctrl =
                  reff.read(convertPulsaRiverpodAdapterProvider.notifier);
              final cancelValue = reff.watch(
                convertPulsaRiverpodAdapterProvider.select(
                  (value) => value.cancelTransValue,
                ),
              );

              return AsyncValueWidget<void>(
                value: cancelValue ?? const AsyncValue.data(null),
                loadingWidget: Container(
                  color: Colors.white,
                  child: RPadding.all(
                    16,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                onSuccess: (_) {
                  return UIButtonBottomMultipleWidget(
                    leftTitleButton: 'Ya, Batalkan',
                    leftOnPressed: () {
                      ctrl.cancelTrans(isCancel: true);
                    },
                    rightTitleButton: 'Tidak, Kembali',
                    rightBgColor: AppColor.brPrimaryStrong,
                    rightColor: Colors.white,
                    rightOnPressed: context.pop,
                  );
                },
                onRetry: () => ctrl.cancelTrans(isCancel: true),
              );
            },
          ),
        ],
      ),
    );

    await StaticWidget.modalBottomWidget(
      context: context,
      widget: item,
    );
  }

  static Future<File?> pickImage({
    required ImageSource imageSource,
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
          return pickImage(
            imageSource: imageSource,
            existingFile: File(imageFileFile.path),
          );
        }

        return File(imageFileFile.path);
      }

      return File(imagePath);
    } catch (e) {
      if (e.toString().contains('camera_access_denied')) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }

    return null;
  }
}
