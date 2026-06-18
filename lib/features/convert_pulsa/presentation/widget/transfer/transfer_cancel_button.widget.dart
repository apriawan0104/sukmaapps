import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import 'transfer_helper.widget.dart';

class TransferCancelButtonWidget extends ConsumerWidget {
  const TransferCancelButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RPadding.all(
      0,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              TransferHelperWidget.cancelTransaction(
                context: context,
                ref: ref,
              );
            },
            style: TextButton.styleFrom(
              minimumSize: Size.fromHeight(34.h),
            ),
            child: Text(
              'Batalkan transaksi',
              style: GoogleFonts.plusJakartaSans(
                color: AppColor.errorFair,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              softWrap: true,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
