import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../domain/entity/transfer.entity.dart';
import '../widget.dart';

class StatusSuccessWidget extends StatelessWidget {
  const StatusSuccessWidget({super.key, required this.model});

  final TransferEntity model;

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
            title: 'Convert Pulsa Berhasil',
            fontSize: 16.sp,
            color: const Color(0xFF001122),
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 2.h),
          UITextPrimaryWidget(
            title: 'Uang kamu sudah kami transfer. Cek rekening, ya!',
            fontSize: 12.sp,
            color: const Color(0xFF293142),
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          UITextPrimaryWidget(
            title:
                'Rp${FormatHelper.formatThousandFromNumber(model.total ?? 0)}',
            fontSize: 24.sp,
            color: const Color(0xFF101828),
            fontWeight: FontWeight.w800,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          DashedDividerWidget(color: const Color(0xFFE7E8F3), height: 1.h),
          SizedBox(height: 16.h),
          Column(
            children: [
              summaryData(
                title: 'Rekening Penerima',
                description: model.bank ?? '',
              ),
              SizedBox(height: 8.h),
              summaryData(
                title: 'No Rekening / Wallet',
                description: model.noRekening ?? '',
              ),
              SizedBox(height: 8.h),
              summaryData(
                title: 'Pemilik  Rekening / Wallet',
                description: model.nameRekening ?? '',
              ),
              SizedBox(height: 8.h),
              summaryData(
                title: 'Biaya Transfer',
                description:
                    'Rp${FormatHelper.formatThousandFromNumber(model.charge ?? 0)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row summaryData({
    required String title,
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UITextPrimaryWidget(
          title: title,
          fontSize: 12.sp,
          color: const Color(0xFF667085),
          fontWeight: FontWeight.w400,
        ),
        UITextPrimaryWidget(
          title: description,
          fontSize: 12.sp,
          color: const Color(0xFF344054),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
