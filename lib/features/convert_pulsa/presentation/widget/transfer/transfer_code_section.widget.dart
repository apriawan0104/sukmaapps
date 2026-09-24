import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class TransferCodeSectionWidget extends StatelessWidget {
  const TransferCodeSectionWidget({
    super.key,
    required this.transfer,
    required this.onDial,
    required this.onSms,
    required this.onCopy,
  });

  final TransferEntity transfer;
  final VoidCallback onDial;
  final VoidCallback onSms;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final nominal = transfer.nominal ?? 0;
    final credit = transfer.credit ?? transfer.nominal ?? 0;

    return RPadding.all(
      16,
      child: UICardPrimaryWidget(
        color: AppColor.whiteFair,
        colorSide: AppColor.whiteFair,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      title: '1',
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
                          text: 'Transfer pulsa ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.blackMassive,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: FormatHelper.formatThousandFromNumber(nominal),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.blackMassive,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' ke nomor sukma berikut',
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
            Container(
              width: double.infinity,
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.whiteMassive,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.w),
                  topRight: Radius.circular(6.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: UITextPrimaryWidget(
                      title: transfer.bucket ?? '',
                      fontSize: 18.sp,
                      color: AppColor.blackMassive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: onCopy,
                    child: Column(
                      children: [
                        Container(
                          padding: REdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.brPrimaryStrong,
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: Icon(
                            Icons.copy,
                            color: AppColor.whiteMassive,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: REdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDBE9FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.w),
                  bottomRight: Radius.circular(6.w),
                ),
              ),
              child: UITextPrimaryWidget(
                title:
                    'Saldo pulsa minimal: ${FormatHelper.formatThousandFromNumber(credit)}',
                fontSize: 14.sp,
                color: const Color(0xFF174994),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            DashedDividerWidget(
              color: AppColor.blackFair,
              height: 1,
            ),
            SizedBox(height: 16.h),
            UITextPrimaryWidget(
                title: 'Pilihan metode transfer pulsa',
                fontSize: 14.sp,
                color: AppColor.blackMassive,
                fontWeight: FontWeight.w400),
            SizedBox(height: 16.h),
            if (transfer.dialupCode?.sms != null &&
                transfer.dialupCode?.sms?.active == true) ...[
              GestureDetector(
                onTap: onSms,
                child: UICardPrimaryWidget(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconSharedConstant.sms,
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: UITextPrimaryWidget(
                          title: 'SMS',
                          fontSize: 14.sp,
                          color: AppColor.blackMassive,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppColor.blackMassive, size: 20.sp),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            GestureDetector(
              onTap: onDial,
              child: UICardPrimaryWidget(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      IconSharedConstant.phoneUssd,
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: UITextPrimaryWidget(
                        title: 'Telepon/USSD',
                        fontSize: 14.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: AppColor.blackMassive, size: 20.sp),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
