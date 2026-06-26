import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';

class UserBlockedWidget extends StatelessWidget {
  const UserBlockedWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SvgPicture.asset(
                  IconSharedConstant.userBlock,
                  width: 160.w,
                  height: 160.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: UITextPrimaryWidget(
                    title: 'Kamu tidak bisa melakukan transaksi',
                    fontSize: 16.sp,
                    color: AppColor.blackMassive,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ),
                Text(
                  'Silakan hubungi Customer Service untuk mengatasi masalah ini',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColor.blackFair,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ],
            ),
          ),
          UIButtonBottomWidget(
            titleButton: 'Kembali ke Home',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
