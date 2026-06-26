import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../config/config.dart';
import '../../../../../core/core.dart';

class TransactionOutstandingWidget extends StatelessWidget {
  const TransactionOutstandingWidget({
    super.key,
    required this.transactionOutstandingAsync,
    required this.onRetry,
    required this.onExpired,
    this.onOpenTransfer,
  });

  final AsyncValue<TransferEntity?> transactionOutstandingAsync;
  final VoidCallback onRetry;
  final VoidCallback onExpired;
  final void Function(TransferEntity transfer)? onOpenTransfer;

  Widget _transactionOutstandingList(
      BuildContext context, TransferEntity? data) {
    return Padding(
      padding: const REdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UITextPrimaryWidget(
            title: 'Transaksi yang perlu diselesaikan',
            fontSize: 16.sp,
            color: const Color(0xFF19202D),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 8.h),
          UICardPrimaryWidget(
            color: AppColor.brPrimaryStrong,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UITextPrimaryWidget(
                          title: 'Transfer pulsa sebelum',
                          fontSize: 16.sp,
                          color: AppColor.whiteMassive,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 4.h),
                        UITextPrimaryWidget(
                          title: FormatHelper.formatDate(
                              data?.expiredAt?.toLocal() ?? DateTime.now()),
                          fontSize: 14.sp,
                          color: AppColor.whiteMassive,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    UICardPrimaryWidget(
                      width: 81.w,
                      color: const Color(0xFFFEE4E2),
                      colorSide: const Color(0xFF7A271A),
                      padding:
                          REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconSharedConstant.timercircle,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: ExpiredCountdownTicker(
                              expiredAt: data?.expiredAt,
                              onExpired: onExpired,
                              builder: (context, remaining) {
                                return UITextPrimaryWidget(
                                  title:
                                      FormatHelper.formatCountdown(remaining),
                                  fontSize: 12.sp,
                                  color: AppColor.errorFair,
                                  fontWeight: FontWeight.w700,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    if (data != null) {
                      onOpenTransfer?.call(data);
                    }
                    context.pushNamed(RouteNames.transfer);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.whiteMassive,
                    foregroundColor: AppColor.brPrimaryStrong,
                    padding:
                        REdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6).w),
                    minimumSize: Size.fromHeight(48.h),
                  ),
                  child: UITextPrimaryWidget(
                    title: 'Lihat Detail',
                    fontSize: 14.sp,
                    color: AppColor.brPrimaryStrong,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _transactionOutstandingLoading() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFDFD9D9),
      highlightColor: const Color(0xFFF2F2FF),
      child: Padding(
        padding: const REdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 10.h,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<TransferEntity?>(
      value: transactionOutstandingAsync,
      onSuccess: (data) {
        if (data == null) return const SizedBox.shrink();
        return _transactionOutstandingList(context, data);
      },
      loadingWidget: _transactionOutstandingLoading(),
      errorWidget: (p0, p1) => Container(padding: EdgeInsets.zero),
      onRetry: onRetry,
    );
  }
}
