import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../text/text_primary.widget.dart';
import 'card_primary.widget.dart';

class UICardStatusWidget extends ConsumerWidget {
  const UICardStatusWidget({
    super.key,
    this.color,
    this.colorSide,
    this.icon = '',
    this.title = '',
    this.subtitle = '',
  });

  final Color? color;
  final Color? colorSide;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const REdgeInsets.all(16),
      child: UICardPrimaryWidget(
        width: double.infinity,
        color: color,
        colorSide: colorSide,
        child: Column(
          children: [
            SvgPicture.asset(icon),
            SizedBox(height: 8.h),
            UITextPrimaryWidget(
              title: title,
              fontSize: 16.sp,
              color: const Color(0xFF101828),
              fontWeight: FontWeight.w700,
            ),
            UITextPrimaryWidget(
              align: TextAlign.center,
              title: subtitle,
              fontSize: 14.sp,
              color: const Color(0xFF344054),
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}

extension StatusCard on UICardStatusWidget {
  UICardStatusWidget get pending => UICardStatusWidget(
        color: const Color(0xFFFEF0C7),
        colorSide: const Color(0xFFB54708),
        icon: IconStatusConstant.pending,
        title: 'Convert Pulsa sedang diproses',
        subtitle:
            'Kami sedang memproses permintaan convert anda. Mohon menunggu beberapa saat',
      );

  UICardStatusWidget get success => UICardStatusWidget(
        color: const Color(0xFFD1FADF),
        colorSide: const Color(0xFF027A48),
        icon: IconStatusConstant.success,
        title: 'Convert Pulsa Berhasil',
        subtitle:
            'Kami telah mengirimkan uang ke rekening anda. Silakan cek rekening secara berkala',
      );

  UICardStatusWidget get failed => UICardStatusWidget(
        color: const Color(0xFFFEE4E2),
        colorSide: const Color(0xFFB42318),
        icon: IconStatusConstant.failed,
        title: 'Convert Pulsa dibatalkan otomatis',
        subtitle:
            'Tidak ada transfer pulsa atau bukti transfer yang kami terima',
      );
}
