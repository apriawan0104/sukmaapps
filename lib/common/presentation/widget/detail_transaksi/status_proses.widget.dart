import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../domain/entity/transfer.entity.dart';
import '../widget.dart';

class StatusProsesWidget extends StatelessWidget {
  const StatusProsesWidget({super.key, required this.model});

  final TransferEntity model;

  @override
  Widget build(BuildContext context) {
    return UICardPrimaryWidget(
      color: AppColor.whiteMassive,
      colorSide: const Color(0xFFE7E8F3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UICardPrimaryWidget(
            color: const Color(0xFFFFF0DB),
            colorSide: const Color(0xFFFFF0DB),
            padding: REdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  size: 18.sp,
                  color: const Color(0xFFC27100),
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: UITextPrimaryWidget(
                    title:
                        'Sedang memeriksa bukti transfer pulsa yang kamu kirim. Mohon tunggu, ya!',
                    fontSize: 12.sp,
                    color: const Color(0xFFC27100),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
                title: 'Memeriksa\nBukti Transfer',
                icon: IconStatusTransaksiConstant.statusProcess,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: cardConvert(
                  title:
                      'Rp${FormatHelper.formatThousandFromNumber(model.nominal ?? 0)}',
                  description: model.providerName ?? '',
                  icon: IconProviderHelper(model.providerName ?? '')
                      .getIconProvider(),
                ),
              ),
              RPadding.symmetric(
                horizontal: 8,
                child: Icon(
                  Icons.arrow_forward,
                  size: 24.sp,
                  color: const Color(0xFF2269D4),
                ),
              ),
              Expanded(
                child: cardConvert(
                  title:
                      'Rp${FormatHelper.formatThousandFromNumber(model.total ?? 0)}',
                  description: 'Saldo ${model.bank ?? ''}',
                  icon: IconBankHelper(model.bank ?? '').getIconBank(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card cardConvert({
    required String title,
    required String description,
    required String icon,
  }) {
    return Card(
      color: AppColor.whiteMassive,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8).w,
        side: BorderSide(
          color: const Color(0xFF989EB8),
          width: 1.w,
        ),
      ),
      elevation: 3,
      child: SizedBox(
        child: RPadding.all(
          8,
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 24.h,
                width: 24.w,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UITextPrimaryWidget(
                    title: title,
                    fontSize: 12.sp,
                    color: AppColor.blackMassive,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  UITextPrimaryWidget(
                    title: description,
                    fontSize: 12.sp,
                    color: const Color(0xFF293142),
                    fontWeight: FontWeight.w400,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
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
