import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app.dart';
import '../../../core/core.dart';
import '../widget/widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          SvgPicture.asset(
            IconSharedConstant.emptyScreen,
            height: 160.h,
            width: 160.w,
          ),
          SizedBox(height: 16.h),
          UITextPrimaryWidget(
            align: TextAlign.center,
            title: 'Belum ada transaksi',
            fontSize: 16.sp,
            color: AppColor.blackMassive,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          UITextPrimaryWidget(
            align: TextAlign.center,
            title:
                'Segera nikmati pengalaman terbaik dalam mengkonversi pulsamu menjadi uang',
            fontSize: 14.sp,
            color: AppColor.blackFair,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
