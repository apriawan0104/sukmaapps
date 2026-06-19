import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../widget.dart';

class StatusFailedWidget extends StatelessWidget {
  const StatusFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      color: AppColor.whiteMassive,
      colorSide: const Color(0xFFE7E8F3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UITextPrimaryWidget(
            title: 'Convert Pulsa Dibatalkan',
            fontSize: 16.sp,
            color: const Color(0xFF001122),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 2.h),
          UITextPrimaryWidget(
            title:
                'Kami belum terima pulsa dari kamu nih. Coba cek lagi bukti transfernya ya!',
            fontSize: 12.sp,
            color: const Color(0xFF293142),
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconProcess(
                title: 'Transaksi\nDibuat',
                icon: IconStatusTransaksiConstant.statusMade,
              ),
              divider(),
              iconProcess(
                title: 'Pengecekan\nGagal',
                icon: IconStatusTransaksiConstant.statusFail,
              ),
              divider(),
              iconProcess(
                title: 'Uang\nDikirim',
                icon: IconStatusTransaksiConstant.statusSuccess,
                colorText: AppColor.whiteRoot,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          UICardInfobox(
            colorBorder: const Color(0xFFB42318),
            colorBg: const Color(0xFFFEE4E2),
            widget: Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  size: 24.sp,
                  color: const Color(0xFFB42318),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: UITextPrimaryWidget(
                    title:
                        'Hubungi CS Sukma Convert kalo kamu sudah mentransfer pulsa.',
                    fontSize: 12.sp,
                    color: const Color(0xFFBC040E),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iconProcess({
    required String title,
    required String icon,
    Color? colorText,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80.w,
          height: 40.h,
          child: SvgPicture.asset(
            icon,
            height: 40.h,
            width: 40.w,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 80.w,
          child: UITextPrimaryWidget(
            title: title,
            fontSize: 12.sp,
            color: colorText ?? const Color(0xFF001122),
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget divider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.h,
          width: 28.w,
          child: Divider(
            color: const Color(0xFFDBE9FF),
            height: 2.h,
            thickness: 2,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 28.w,
          height: 32.h,
        ),
      ],
    );
  }
}
