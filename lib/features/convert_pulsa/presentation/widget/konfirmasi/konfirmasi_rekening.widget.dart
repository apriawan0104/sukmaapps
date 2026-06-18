import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class KonfirmasiRekeningWidget extends StatelessWidget {
  const KonfirmasiRekeningWidget({
    super.key,
    required this.chooseBankName,
    required this.chooseOtherBankName,
    required this.chooseBankCharge,
    required this.chooseAccountName,
    required this.chooseAccountNumber,
    required this.nominalTerima,
  });

  final String? chooseBankName;
  final String? chooseOtherBankName;
  final int? chooseBankCharge;
  final String? chooseAccountName;
  final String? chooseAccountNumber;
  final double nominalTerima;

  String get _displayBankName {
    final otherName = chooseOtherBankName ?? '';
    if (otherName.isEmpty) {
      return chooseBankName ?? '';
    }
    return otherName;
  }

  int get _uangDiterima {
    final charge = chooseBankCharge ?? 0;
    return (nominalTerima - charge).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rekening Penerima',
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
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      IconBankHelper(chooseBankName ?? '').getIconBank(),
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        _displayBankName,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF101828),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    UICardChargeWidget(charge: chooseBankCharge ?? 0),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: UICardPrimaryWidget(
                        padding: REdgeInsets.all(8),
                        color: AppColor.whiteMassive,
                        colorSide: AppColor.whiteMassive,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chooseAccountName ?? '',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF344054),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              chooseAccountNumber ?? '',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF344054),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: UICardPrimaryWidget(
                        padding: REdgeInsets.all(8),
                        color: const Color(0xFFD1E9FF),
                        colorSide: const Color(0xFFD1E9FF),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Uang yang diterima',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF175CD3),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Rp${FormatHelper.formatThousandFromNumber(_uangDiterima)}',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF175CD3),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
