import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';

class RekeningFavoriteWidget extends StatelessWidget {
  const RekeningFavoriteWidget({
    super.key,
    required this.ctrl,
    required this.rekeningFavValue,
    required this.chooseBankId,
    required this.chooseBankName,
    required this.chooseBankCharge,
    required this.chooseOtherBankName,
    required this.chooseAccountNumber,
    required this.chooseAccountName,
  });

  final ConvertPulsaController ctrl;
  final AsyncValue<List<RekeningFavEntity>> rekeningFavValue;
  final int? chooseBankId;
  final String? chooseBankName;
  final int? chooseBankCharge;
  final String? chooseOtherBankName;
  final String? chooseAccountNumber;
  final String? chooseAccountName;

  bool _isSelected(RekeningFavEntity fav) {
    return chooseBankId == fav.idbank &&
        chooseAccountNumber == fav.noRekening &&
        chooseAccountName == fav.name &&
        (chooseOtherBankName ?? '') == (fav.bankOptional ?? '');
  }

  String _favoriteTitle(RekeningFavEntity fav) {
    if (fav.bankOptional == null) {
      return '${fav.name} - ${fav.noRekening}';
    }
    return '${fav.bankOptional} - ${fav.name} - ${fav.noRekening}';
  }

  Widget _cardEmptyFavorite() {
    return UICardDottedWidget(
      width: 343.w,
      child: Row(
        children: [
          SvgPicture.asset(
            IconSharedConstant.logo,
            height: 32.h,
            width: 32.w,
          ),
          SizedBox(width: 16.w),
          Text(
            'Belum ada rekening tersimpan',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF344054),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardFavorite({
    required RekeningFavEntity fav,
    required bool isSelected,
  }) {
    return Container(
      margin: REdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          ctrl.chooseRekening(
            bankId: fav.idbank ?? 0,
            bankName: fav.bank ?? '',
            bankCharge: fav.charge ?? 0,
            otherBankName: fav.bankOptional,
            accountNumber: fav.noRekening ?? '',
            accountName: fav.name ?? '',
          );
        },
        child: UICardPrimaryWidget(
          colorSide: isSelected ? AppColor.brPrimaryStrong : null,
          color: isSelected ? AppColor.whiteFair : null,
          width: 343.w,
          child: Row(
            children: [
              Image.asset(
                IconBankHelper(fav.bank ?? '').getIconBank(),
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _favoriteTitle(fav),
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF344054),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        UICardChargeWidget(charge: fav.charge ?? 0),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => ctrl.deleteRekeningFav(fav.id.toString()),
                child: Icon(
                  Icons.delete_outlined,
                  size: 24.sp,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rekening Favorit',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          AsyncValueWidget<List<RekeningFavEntity>>(
            value: rekeningFavValue,
            onSuccess: (data) {
              if (data.isNotEmpty) {
                return Column(
                  children: List.generate(
                    data.length,
                    (index) => _cardFavorite(
                      fav: data[index],
                      isSelected: _isSelected(data[index]),
                    ),
                  ),
                );
              }
              return _cardEmptyFavorite();
            },
            onRetry: ctrl.getRekeningFav,
          ),
        ],
      ),
    );
  }
}
