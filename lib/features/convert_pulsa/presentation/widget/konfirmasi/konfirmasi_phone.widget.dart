import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class KonfirmasiPhoneWidget extends StatelessWidget {
  const KonfirmasiPhoneWidget({
    super.key,
    required this.choosePhone,
    required this.providerName,
  });

  final String? choosePhone;
  final String? providerName;

  @override
  Widget build(BuildContext context) {
    final iconProvider =
        IconProviderHelper(providerName ?? '').getIconProvider();

    return Padding(
      padding: const REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Pengirim',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          UICardPrimaryWidget(
            width: 343.w,
            colorSide: AppColor.whiteFair,
            color: AppColor.whiteFair,
            child: Row(
              children: [
                Image.asset(
                  iconProvider,
                  height: 32.h,
                  width: 32.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    providerName ?? '',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF1D2939),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  choosePhone ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
