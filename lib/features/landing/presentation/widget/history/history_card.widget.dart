import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../../domain/entity/entity.dart';
import 'history_status_badge.widget.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({
    super.key,
    required this.history,
    required this.onTap,
  });

  final HistoryConvertEntity history;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title =
        '${history.provider?.name ?? ''} ${FormatHelper.formatThousandFromNumber(history.nominal)}';
    final rate = '${history.noSending} Rate ${history.rate}';
    final date = history.createdAt != null
        ? FormatHelper.formatDate(history.createdAt!.toLocal())
        : '-';
    final nominal =
        'Rp${FormatHelper.formatThousandFromNumber(history.total)}';
    final status = StatusTransHelper.getStatus(history.status ?? 0);
    final isHold = history.isHold ?? false;
    final cancelByAdmin = history.cancelByAdmin ?? false;

    return RPadding.only(
      bottom: 16,
      child: InkWell(
        onTap: onTap,
        child: UICardPrimaryWidget(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                IconProviderHelper(history.provider?.name ?? '')
                    .getIconProvider(),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _HistoryDetailColumn(
                  title: title,
                  rate: rate,
                  date: date,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  UITextPrimaryWidget(
                    title: nominal,
                    fontSize: 14.sp,
                    color: const Color(0xFF001122),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 4.h),
                  HistoryStatusBadge.fromStatus(
                    status: status,
                    isHold: isHold,
                    cancelByAdmin: cancelByAdmin,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryDetailColumn extends StatelessWidget {
  const _HistoryDetailColumn({
    required this.title,
    required this.rate,
    required this.date,
  });

  final String title;
  final String rate;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UITextPrimaryWidget(
          title: title,
          fontSize: 14.sp,
          color: const Color(0xFF001122),
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 4.h),
        UITextPrimaryWidget(
          title: rate,
          fontSize: 12.sp,
          color: const Color(0xFF1D2939),
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 4.h),
        UITextPrimaryWidget(
          title: date,
          fontSize: 10.sp,
          color: const Color(0xFF667085),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
