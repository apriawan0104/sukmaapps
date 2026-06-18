import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../adapter/convert_pulsa.adapter.dart';
import 'transfer_helper.widget.dart';

class TransferUploadSectionWidget extends ConsumerWidget {
  const TransferUploadSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(convertPulsaRiverpodAdapterProvider);
    final transfer = state.transferData;
    final imagePath = state.imagePath;
    final hasEvidence = transfer?.evidence?.imageId != null;
    final hasImage = imagePath.isNotEmpty || hasEvidence;
    final uploadValue = state.uploadImageValue ?? const AsyncValue.data(null);
    final deleteValue = state.deleteImageValue ?? const AsyncValue.data(null);
    final isProcessing = uploadValue.isLoading || deleteValue.isLoading;

    return RPadding.all(
      16,
      child: UICardPrimaryWidget(
        color: AppColor.whiteFair,
        colorSide: AppColor.whiteFair,
        child: Column(
          children: [
            Row(
              children: [
                UICardPrimaryWidget(
                  padding: REdgeInsets.all(0),
                  height: 32.h,
                  width: 32.w,
                  colorSide: AppColor.blackFair,
                  color: AppColor.whiteMassive,
                  child: Center(
                    child: UITextPrimaryWidget(
                      title: '2',
                      fontSize: 16.sp,
                      color: AppColor.blackFair,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Kirimkan bukti transfer pulsa',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.blackMassive,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' untuk mempercepat proses verifikasi',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.blackMassive,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (isProcessing)
              const Center(child: CircularProgressIndicator())
            else if (hasImage)
              _TransferImageCard(
                imagePath: imagePath,
                imageId: transfer?.evidence?.imageId,
              )
            else
              const _TransferEmptyImageCard(),
          ],
        ),
      ),
    );
  }
}

class _TransferEmptyImageCard extends ConsumerWidget {
  const _TransferEmptyImageCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);

    return GestureDetector(
      onTap: () {
        TransferHelperWidget.uploadImage(
          context: context,
          ref: ref,
          onCompleted: (file) async {
            if (file == null) return;
            if (!context.mounted) return;
            Navigator.of(context).pop();
            await ctrl.saveImagePath(file.path);
          },
        );
      },
      child: UICardDottedWidget(
        width: 343.w,
        child: Row(
          children: [
            SvgPicture.asset(
              IconSharedConstant.imageEmpty,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 16.w),
            Text(
              'Pilih gambar',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF293142),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransferImageCard extends ConsumerWidget {
  const _TransferImageCard({
    required this.imagePath,
    required this.imageId,
  });

  final String imagePath;
  final int? imageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(convertPulsaRiverpodAdapterProvider.notifier);

    return GestureDetector(
      onTap: () {
        if (imagePath.isEmpty) return;

        showDialog<void>(
          context: context,
          builder: (_) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: InteractiveViewer(
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: UICardDottedWidget(
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (imageId != null)
              Image.network(
                WebServiceConstant.imageUrl(imageId!),
                height: 40.h,
                width: 40.w,
                fit: BoxFit.contain,
              )
            else
              Image.file(
                File(imagePath),
                height: 40.h,
                width: 40.w,
                fit: BoxFit.contain,
              ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                imageId != null
                    ? imageId.toString()
                    : imagePath.split('/').last,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF293142),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Transform.rotate(
              angle: 0.7854,
              child: IconButton(
                onPressed: ctrl.deleteImagePath,
                icon: Icon(
                  Icons.add_circle,
                  size: 24.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
