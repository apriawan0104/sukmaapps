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
    required this.onCopy,
  });

  final TransferEntity transfer;
  final VoidCallback onDial;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final nominal = transfer.nominal ?? 0;
    final credit = transfer.credit ?? transfer.nominal ?? 0;
    final dialupCode = transfer.dialupCode ?? '';

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
                children: [
                  Flexible(
                    child: UITextPrimaryWidget(
                      title: dialupCode,
                      fontSize: 18.sp,
                      color: AppColor.blackMassive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: onDial,
                    child: Column(
                      children: [
                        Container(
                          padding: REdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColor.brPrimaryStrong,
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: SvgPicture.asset(
                            IconSharedConstant.send,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        UITextPrimaryWidget(
                          title: 'Send',
                          fontSize: 12.sp,
                          color: AppColor.brPrimaryStrong,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
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
                        SizedBox(height: 4.h),
                        UITextPrimaryWidget(
                          title: 'Copy',
                          fontSize: 12.sp,
                          color: AppColor.brPrimaryStrong,
                          fontWeight: FontWeight.w700,
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
          ],
        ),
      ),
    );
  }
}
