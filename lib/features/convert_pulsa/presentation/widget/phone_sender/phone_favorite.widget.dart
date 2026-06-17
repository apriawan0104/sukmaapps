import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../controller/convert_pulsa.controller.dart';

class PhoneFavoriteWidget extends StatelessWidget {
  const PhoneFavoriteWidget({
    super.key,
    required this.ctrl,
    required this.phoneFavValue,
    required this.choosePhone,
  });

  final ConvertPulsaController ctrl;
  final AsyncValue<List<PhoneFavEntity>> phoneFavValue;
  final String? choosePhone;

  Widget _cardEmptyFavorite() {
    return UICardPrimaryWidget(
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
            'Belum ada nomor tersimpan',
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
    required String namaProvider,
    required String nomor,
    required int id,
    required String rate,
    required int providerid,
    required int providerMinConv,
    required int providerMaxConv,
    required bool isSelected,
  }) {
    return Container(
      margin: REdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          ctrl.choosePhone(
              phone: nomor,
              provider: ProviderEntity(
                  name: namaProvider,
                  id: providerid,
                  maksConvert: providerMaxConv,
                  minConvert: providerMinConv,
                  rate: rate));
        },
        child: UICardPrimaryWidget(
          width: 343.w,
          colorSide: isSelected ? AppColor.brPrimaryStrong : null,
          color: isSelected ? AppColor.whiteFair : null,
          child: Row(
            children: [
              Image.asset(
                IconProviderHelper(namaProvider).getIconProvider(),
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  nomor,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => ctrl.deletePhoneFav(id.toString()),
                child: Icon(
                  Icons.delete_outlined,
                  size: 24.sp,
                  color: Colors.red,
                ),
              )
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
            'Nomor Favorit',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          AsyncValueWidget<List<PhoneFavEntity>>(
            value: phoneFavValue,
            onSuccess: (p0) {
              if (p0.isNotEmpty) {
                return Column(
                  children: List.generate(
                    p0.length,
                    (index) => _cardFavorite(
                      namaProvider: p0[index].provider!,
                      nomor: p0[index].number!,
                      id: p0[index].id!,
                      providerid: p0[index].providerId!,
                      rate: p0[index].rate!,
                      providerMinConv: p0[index].minConvert ?? 0,
                      providerMaxConv: p0[index].maksConvert ?? 0,
                      isSelected: choosePhone == p0[index].number,
                    ),
                  ),
                );
              } else {
                return _cardEmptyFavorite();
              }
            },
            onRetry: ctrl.getPhoneFav,
          ),
        ],
      ),
    );
  }
}
