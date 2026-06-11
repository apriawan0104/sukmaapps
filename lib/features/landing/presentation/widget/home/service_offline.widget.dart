import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

class ServiceOfflineWidget extends StatelessWidget {
  const ServiceOfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      color: const Color(0xFFB3292B),
      child: Row(
        children: [
          Icon(Icons.warning_rounded,
              size: 32.sp, color: AppColor.whiteMassive),
          SizedBox(width: 12.w),
          Expanded(
            child: UITextPrimaryWidget(
                title: 'Layanan sedang istirahat. Tunggu beberapa saat lagi',
                fontSize: 12.sp,
                color: AppColor.whiteMassive,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
