import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';
import 'add_rekening.widget.dart';

class AddRekeningReceiverWidget extends StatelessWidget {
  const AddRekeningReceiverWidget({
    super.key,
    required this.ctrl,
    required this.chooseBankId,
    required this.chooseBankName,
    required this.chooseBankCharge,
    required this.chooseOtherBankName,
    required this.chooseAccountNumber,
    required this.chooseAccountName,
  });

  final ConvertPulsaController ctrl;
  final int? chooseBankId;
  final String? chooseBankName;
  final int? chooseBankCharge;
  final String? chooseOtherBankName;
  final String? chooseAccountNumber;
  final String? chooseAccountName;

  void _showInputRekening(BuildContext context) {
    ctrl.isSaveRekening(false);
    RekeningDialogWidget.listReceiverAccount(context: context, ctrl: ctrl);
  }

  String get _displayBankName {
    final otherName = chooseOtherBankName ?? '';
    if (otherName.isEmpty) {
      return chooseBankName ?? '';
    }
    return otherName;
  }

  Widget _cardEmptyRekening(BuildContext context) {
    return UICardDottedWidget(
      width: 343.w,
      child: InkWell(
        onTap: () => _showInputRekening(context),
        child: Row(
          children: [
            SvgPicture.asset(
              IconSharedConstant.addCircle,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 16.w),
            Text(
              'Tambahkan Rekening',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF293142),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardRekening() {
    return UICardDottedWidget(
      width: 343.w,
      color: AppColor.whiteFair,
      colorSide: const Color(0xFF344054),
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
          UICardPrimaryWidget(
            padding: REdgeInsets.all(8),
            color: AppColor.whiteMassive,
            colorSide: AppColor.whiteMassive,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chooseAccountName ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF344054),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  chooseAccountNumber ?? '',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF344054),
                    fontSize: 14.sp,
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

  @override
  Widget build(BuildContext context) {
    final hasRekening = chooseBankId != null;

    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Rekening Penerima',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              if (hasRekening)
                GestureDetector(
                  onTap: () => _showInputRekening(context),
                  child: Text(
                    'Ganti',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF164994),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          hasRekening ? _cardRekening() : _cardEmptyRekening(context),
        ],
      ),
    );
  }
}
