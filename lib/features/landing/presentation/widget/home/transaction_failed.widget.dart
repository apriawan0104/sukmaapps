import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

class TransactionFailedWidget extends StatelessWidget {
  const TransactionFailedWidget({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      color: AppColor.brPrimaryStrong,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UITextPrimaryWidget(
              title: 'Transaksimu gak bisa diproses.',
              fontSize: 16.sp,
              color: AppColor.whiteMassive,
              fontWeight: FontWeight.w700),
          SizedBox(height: 4.h),
          UITextPrimaryWidget(
              title: 'Lihat detailnya dibawah ini ya!',
              fontSize: 14.sp,
              color: AppColor.whiteHeavy,
              fontWeight: FontWeight.w400),
          SizedBox(height: 16.h),
          UIButtonPrimaryWidget(
            backgroundColor: AppColor.whiteMassive,
            foregroundColor: AppColor.brPrimaryStrong,
            titleButton: 'Lihat detail',
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
