import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';

class NominalInfoWidget extends StatelessWidget {
  const NominalInfoWidget({
    super.key,
    required this.ctrl,
    required this.calcNominalValue,
    required this.providerName,
    required this.rate,
    required this.nominalText,
  });

  final ConvertPulsaController ctrl;
  final AsyncValue<double> calcNominalValue;
  final String providerName;
  final String rate;
  final String nominalText;

  @override
  Widget build(BuildContext context) {
    final credit = calcNominalValue.value ?? 0;
    if (credit <= 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const REdgeInsets.all(16),
      child: Column(
        children: [
          UICardInfobox(
            colorBorder: const Color(0xFF175CD3),
            colorBg: const Color(0xFFD1E9FF),
            widget: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        'Rate $providerName $rate',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF101828),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                AsyncValueWidget<double>(
                  value: calcNominalValue,
                  skipLoadingOnReload: true,
                  onSuccess: (amount) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Anda akan mendapatkan uang sebesar ',
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF344054),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: FormatHelper.formatThousandFromNumber(amount),
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF344054),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onRetry: () {
                    ctrl.calcNominal(nominalText);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
