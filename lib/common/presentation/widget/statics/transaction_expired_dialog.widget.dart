import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../buttons/button_primary.widget.dart';
import '../text/text_primary.widget.dart';
import 'static.widget.dart';

class TransactionExpiredDialog {
  TransactionExpiredDialog._();

  static void show({
    required BuildContext context,
    VoidCallback? onDismissed,
  }) {
    StaticWidget.showDialogCustom(
      context: context,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UITextPrimaryWidget(
            title: 'Transaksi Kadaluarsa',
            fontSize: 16.sp,
            color: AppColor.blackMassive,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          UITextPrimaryWidget(
            title:
                'Waktu transaksi sudah habis. Jika kamu sudah melakukan transfer pulsa, silakan hubungi Customer Service',
            fontSize: 14.sp,
            color: AppColor.blackFair,
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          UIButtonPrimaryWidget(
            titleButton: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
              onDismissed?.call();
            },
          ),
        ],
      ),
    );
  }
}
