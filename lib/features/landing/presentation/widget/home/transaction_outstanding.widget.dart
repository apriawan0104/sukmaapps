import 'dart:async';

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
  });

  final AsyncValue<List<TransferEntity>> transactionOutstandingAsync;
  final VoidCallback onRetry;
  final VoidCallback onExpired;

  Widget _transactionOutstandingList(
      BuildContext context, List<TransferEntity> data) {
    return Padding(
      padding: const REdgeInsets.all(16),
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
                              data.first.expiredAt?.toLocal() ??
                                  DateTime.now()),
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
                            child: _TransactionExpiredCountdown(
                              expiredAt: data.first.expiredAt,
                              onExpired: onExpired,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => context.pushNamed(RouteNames.transfer),
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
    return AsyncValueWidget<List<TransferEntity>>(
      value: transactionOutstandingAsync,
      onSuccess: (data) => _transactionOutstandingList(context, data),
      loadingWidget: _transactionOutstandingLoading(),
      errorWidget: (p0, p1) => Container(padding: EdgeInsets.zero),
      onRetry: onRetry,
    );
  }
}

class _TransactionExpiredCountdown extends StatefulWidget {
  const _TransactionExpiredCountdown({
    required this.expiredAt,
    required this.onExpired,
  });

  final DateTime? expiredAt;
  final VoidCallback onExpired;

  @override
  State<_TransactionExpiredCountdown> createState() =>
      _TransactionExpiredCountdownState();
}

class _TransactionExpiredCountdownState
    extends State<_TransactionExpiredCountdown> {
  Timer? _timer;
  Duration _remaining = Duration.zero;
  bool _hasShownExpiredDialog = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant _TransactionExpiredCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expiredAt != widget.expiredAt) {
      _timer?.cancel();
      _hasShownExpiredDialog = false;
      _startTimer();
    }
  }

  void _startTimer() {
    final expiredAt = widget.expiredAt?.toLocal();
    if (expiredAt == null) {
      setState(() => _remaining = Duration.zero);
      return;
    }

    _updateRemaining(expiredAt);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      _updateRemaining(expiredAt);
    });
  }

  void _updateRemaining(DateTime expiredAt) {
    final diff = expiredAt.difference(DateTime.now());

    if (diff.inSeconds <= 0) {
      setState(() => _remaining = Duration.zero);
      _timer?.cancel();
      _handleExpired();
      return;
    }

    setState(() => _remaining = diff);
  }

  void _handleExpired() {
    if (_hasShownExpiredDialog || !mounted) return;
    _hasShownExpiredDialog = true;

    StaticWidget.showDialogCustom(
      context: context,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UITextPrimaryWidget(
            title: 'Transaksi Kadaluarsa',
            fontSize: 16.sp,
            color: AppColor.blackMassive,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          UITextPrimaryWidget(
            title:
                'Waktu transaksi sudah habis. Jika kamu sudah melakukan transfer pulsa, silakan hubungi Customer Service',
            fontSize: 14.sp,
            color: AppColor.blackFair,
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          UIButtonPrimaryWidget(
            titleButton: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
              widget.onExpired();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UITextPrimaryWidget(
      title: FormatHelper.formatCountdown(_remaining),
      fontSize: 12.sp,
      color: AppColor.errorFair,
      fontWeight: FontWeight.w700,
    );
  }
}
