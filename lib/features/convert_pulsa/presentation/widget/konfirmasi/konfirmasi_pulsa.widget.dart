import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class KonfirmasiPulsaWidget extends StatelessWidget {
  const KonfirmasiPulsaWidget({
    super.key,
    required this.nominalPulsa,
    required this.nominalTerima,
  });

  final String? nominalPulsa;
  final double nominalTerima;

  @override
  Widget build(BuildContext context) {
    final pulsa = CalcNominalHelper.parseNominal(nominalPulsa ?? '');

    return Padding(
      padding: const REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nominal Pulsa',
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
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pulsa ${FormatHelper.formatThousandFromNumber(pulsa)}',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF101828),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  IconSharedConstant.transfer,
                  width: 32.w,
                  height: 32.h,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Rp${FormatHelper.formatThousandFromNumber(nominalTerima)}',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF101828),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
