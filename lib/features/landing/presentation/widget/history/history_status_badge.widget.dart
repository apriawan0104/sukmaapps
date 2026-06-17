import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/enum/status.enum.dart';

class HistoryStatusBadge extends StatelessWidget {
  const HistoryStatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  factory HistoryStatusBadge.fromStatus({
    required Status status,
    required bool isHold,
    required bool cancelByAdmin,
  }) {
    if (isHold) {
      return HistoryStatusBadge._hold();
    }

    switch (status) {
      case Status.outstanding:
        return HistoryStatusBadge._pending();
      case Status.proses:
        return HistoryStatusBadge._process();
      case Status.success:
        return HistoryStatusBadge._success();
      case Status.failed:
        return cancelByAdmin
            ? HistoryStatusBadge._failed()
            : HistoryStatusBadge._cancel();
    }
  }

  factory HistoryStatusBadge._hold() {
    return const HistoryStatusBadge(
      label: 'Hold',
      backgroundColor: Color(0xFFFEF0C7),
      textColor: Color(0xFFB54708),
    );
  }

  factory HistoryStatusBadge._pending() {
    return const HistoryStatusBadge(
      label: 'Hold',
      backgroundColor: Color(0xFFFEF0C7),
      textColor: Color(0xFFB54708),
    );
  }

  factory HistoryStatusBadge._process() {
    return HistoryStatusBadge(
      label: 'Pengecekan',
      backgroundColor: const Color(0xFFDBE9FF),
      textColor: AppColor.brPrimaryStrong,
    );
  }

  factory HistoryStatusBadge._success() {
    return const HistoryStatusBadge(
      label: 'Berhasil',
      backgroundColor: Color(0xFFD1FADF),
      textColor: Color(0xFF027A48),
    );
  }

  factory HistoryStatusBadge._failed() {
    return const HistoryStatusBadge(
      label: 'Ditolak',
      backgroundColor: Color(0xFFFEE4E2),
      textColor: Color(0xFFB42318),
    );
  }

  factory HistoryStatusBadge._cancel() {
    return const HistoryStatusBadge(
      label: 'Dibatalkan',
      backgroundColor: Color(0xFFFEE4E2),
      textColor: Color(0xFFB42318),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      color: backgroundColor,
      colorSide: backgroundColor,
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: UITextPrimaryWidget(
        title: label,
        fontSize: 12.sp,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
