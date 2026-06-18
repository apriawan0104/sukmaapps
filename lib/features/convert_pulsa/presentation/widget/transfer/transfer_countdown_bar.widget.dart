import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class TransferCountdownBarWidget extends StatelessWidget {
  const TransferCountdownBarWidget({
    super.key,
    required this.expiredAt,
    this.onExpired,
  });

  final DateTime? expiredAt;
  final VoidCallback? onExpired;

  @override
  Widget build(BuildContext context) {
    return ExpiredCountdownTicker(
      expiredAt: expiredAt,
      onExpired: onExpired,
      builder: (context, remaining) {
        return Container(
          padding: REdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: AppColor.errorFair,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UITextPrimaryWidget(
                title: 'Sisa waktu transaksi kamu',
                fontSize: 14.sp,
                color: AppColor.whiteMassive,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(width: 6.w),
              UITextPrimaryWidget(
                title: FormatHelper.formatCountdown(remaining),
                fontSize: 14.sp,
                color: AppColor.whiteMassive,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        );
      },
    );
  }
}
