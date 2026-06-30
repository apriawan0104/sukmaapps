import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../adapter/convert_pulsa.adapter.dart';
import 'transfer_pick_image.helper.dart';
import 'transfer_picked_image.dart';

class TransferHelperWidget {
  static Future<void> uploadImage({
    required BuildContext context,
    required WidgetRef ref,
    required Future<void> Function(TransferPickedImage? image) onCompleted,
  }) async {
    if (kIsWeb) {
      final image = await pickTransferImage();
      await onCompleted(image);
      return;
    }

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
                    final image = await pickTransferImage(
                      imageSource: ImageSource.camera,
                    );
                    await onCompleted(image);
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
                    final image = await pickTransferImage(
                      imageSource: ImageSource.gallery,
                    );
                    await onCompleted(image);
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
}
