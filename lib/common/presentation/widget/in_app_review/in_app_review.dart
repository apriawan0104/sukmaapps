import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../service/in_app_review.service.dart';
import '../widget.dart';

class InAppReviewWidget {
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    final hasMetMinTransactions = await ref
        .read(inAppReviewServiceProvider.notifier)
        .hasMetMinimumTransactions();
    if (hasMetMinTransactions) {
      final Widget item = Container(
        color: Colors.white,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SvgPicture.asset(
                    IconSharedConstant.rating,
                    width: 160.w,
                    height: 160.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: UITextPrimaryWidget(
                      title: 'Suka dengan Aplikasi Sukma Convert?',
                      fontSize: 14.sp,
                      color: AppColor.blackMassive,
                      fontWeight: FontWeight.w700,
                      align: TextAlign.start,
                    ),
                  ),
                  UITextPrimaryWidget(
                    title:
                        'Bantu kami dengan menuliskan review dan rating di Play Store dan App Store',
                    fontSize: 12.sp,
                    color: AppColor.blackFair,
                    fontWeight: FontWeight.w400,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            UIButtonBottomMultipleWidget(
              leftTitleButton: 'Lain Kali',
              leftOnPressed: () async {
                await ref.read(inAppReviewServiceProvider.notifier).skipReview();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              rightTitleButton: 'Tulis Review',
              rightBgColor: AppColor.brPrimaryStrong,
              rightColor: Colors.white,
              rightOnPressed: () {
                ref.read(inAppReviewServiceProvider.notifier).openStoreListing();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
      if (context.mounted) {
        await StaticWidget.modalBottomWidget(
          isDismissible: false,
          isShowDragHandling: false,
          context: context,
          widget: item,
        );
      }
    }
  }
}
