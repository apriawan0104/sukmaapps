import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../core/core.dart';
import 'buttons/button_primary.widget.dart';
import 'text/text_primary.widget.dart';
import 'statics/static.widget.dart';

class PartialUpdateDialog {
  PartialUpdateDialog._();

  static void show({required BuildContext context}) {
    StaticWidget.showDialogCustom(
      context: context,
      canPop: true,
      padding: REdgeInsets.all(23.5),
      widget: const _PartialUpdateContent(),
    );
  }
}

class _PartialUpdateContent extends StatelessWidget {
  const _PartialUpdateContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconSharedConstant.forceUpdate,
          height: 160.h,
          width: 160.w,
        ),
        SizedBox(height: 24.h),
        UITextPrimaryWidget(
          title: 'Update Aplikasi dulu, Yuk!',
          fontSize: 16.sp,
          color: AppColor.blackMassive,
          fontWeight: FontWeight.w700,
          align: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        UITextPrimaryWidget(
          title:
              'Versi terbaru aplikasi telah dirilis untuk meningkatkan kualitas layanan kami',
          fontSize: 14.sp,
          color: AppColor.blackMassive,
          fontWeight: FontWeight.w400,
          align: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        UIButtonPrimaryWidget(
          titleButton: 'Update Sekarang',
          onPressed: UriHelper.goToStore,
        ),
        SizedBox(height: 16.h),
        UIButtonPrimaryWidget(
          backgroundColor: AppColor.whiteMassive,
          foregroundColor: AppColor.brPrimaryStrong,
          titleButton: 'Lain Kali',
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
