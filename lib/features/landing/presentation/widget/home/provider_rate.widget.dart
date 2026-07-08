import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../../domain/entity/entity.dart';

class ProviderRateWidget extends StatelessWidget {
  const ProviderRateWidget(
      {super.key,
      required this.rateAsync,
      required this.onTapConvert,
      required this.onRetry});
  final AsyncValue<List<RateEntity>> rateAsync;
  final VoidCallback onTapConvert;
  final VoidCallback onRetry;

  Container _cardRate(
      {required String nameProvider,
      required String rate,
      required String nominal,
      required bool isActive}) {
    String iconProvider = IconProviderHelper(nameProvider).getIconProvider();
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: ShapeDecoration(
        color: AppColor.whiteHeavy,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
          borderRadius: BorderRadius.circular(6).w,
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(iconProvider),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.64.w,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: AppColor.whiteSoft,
                  ),
                  borderRadius: BorderRadius.circular(4).w,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameProvider,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF344054),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  UITextPrimaryWidget(
                      title: nominal,
                      fontSize: 12.sp,
                      color: AppColor.blackFair,
                      fontWeight: FontWeight.w400)
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: isActive
                    ? const Color(0xFFD1FFEB)
                    : const Color(0xFFFFD1D2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4).w),
              ),
              child: isActive
                  ? UITextPrimaryWidget(
                      title: 'Rate : $rate',
                      fontSize: 12.sp,
                      color: const Color(0xFF0F8A11),
                      fontWeight: FontWeight.w400)
                  : UITextPrimaryWidget(
                      title: 'Tidak Aktif',
                      fontSize: 12.sp,
                      color: const Color(0xFF941719),
                      fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardLoading() {
    List<Map<String, dynamic>> nameProvider = [
      {
        "name": "Axis",
        "maks_balance": 1000000,
        "min_convert": 25000,
        "maks_convert": 1000000,
        "rate": "0.87",
        "provider_id": 2,
        "is_active": true
      },
      {
        "name": "Indosat",
        "maks_balance": 1000000,
        "min_convert": 25000,
        "maks_convert": 1000000,
        "rate": "0.88",
        "provider_id": 6,
        "is_active": true
      },
      {
        "name": "Smartfren",
        "maks_balance": 1000000,
        "min_convert": 30000,
        "maks_convert": 1000000,
        "rate": "0.78",
        "provider_id": 5,
        "is_active": true
      },
      {
        "name": "Telkomsel",
        "maks_balance": 1000000,
        "min_convert": 30000,
        "maks_convert": 1000000,
        "rate": "0.82",
        "provider_id": 1,
        "is_active": true
      },
      {
        "name": "Three",
        "maks_balance": 1000000,
        "min_convert": 25000,
        "maks_convert": 1000000,
        "rate": "0.83",
        "provider_id": 4,
        "is_active": true
      },
      {
        "name": "XL",
        "maks_balance": 1000000,
        "min_convert": 25000,
        "maks_convert": 1000000,
        "rate": "0.87",
        "provider_id": 3,
        "is_active": true
      }
    ];

    return Column(
      children: nameProvider.map((element) {
        String iconProvider =
            IconProviderHelper(element['name']).getIconProvider();
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: ShapeDecoration(
            color: AppColor.whiteHeavy,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
              borderRadius: BorderRadius.circular(6).w,
            ),
          ),
          child: Padding(
            padding: REdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(iconProvider),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.64.w,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: AppColor.whiteSoft,
                      ),
                      borderRadius: BorderRadius.circular(4).w,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element['name'],
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF344054),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      UITextPrimaryWidget(
                          title:
                              '${FormatHelper.formatThousandFromNumber(element['min_convert'])} s/d ${FormatHelper.formatThousandFromNumber(element['maks_convert'])}',
                          fontSize: 12.sp,
                          color: AppColor.blackFair,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Shimmer.fromColors(
                    baseColor: const Color(0xFFDFD9D9),
                    highlightColor: const Color(0xFFF2F2FF),
                    child: Container(
                      width: 77.w,
                      height: 26.h,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _errorWidget() {
    return UICardPrimaryWidget(
      color: const Color(0xFFF8F8FC),
      child: Row(
        children: [
          SvgPicture.asset(IconSharedConstant.offlineSignal,
              width: 40.w, height: 40.w),
          SizedBox(width: 16.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Terjadi Gangguan\n',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.sp,
                      color: AppColor.blackFair,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'Periksa koneksi internet kamu dan reload',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          InkWell(
            onTap: onRetry,
            child: UITextPrimaryWidget(
              title: 'Reload',
              fontSize: 14.sp,
              color: AppColor.errorFair,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<RateEntity>>(
        value: rateAsync,
        loadingWidget: _cardLoading(),
        errorWidget: (p0, p1) => _errorWidget(),
        onSuccess: (p0) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              p0.length,
              (index) {
                return InkWell(
                  onTap: onTapConvert,
                  child: _cardRate(
                      nameProvider: p0[index].name!,
                      rate: p0[index].rate!,
                      isActive: p0[index].isActive!,
                      nominal:
                          '${FormatHelper.formatThousandFromNumber(p0[index].minConvert)} s/d ${FormatHelper.formatThousandFromNumber(p0[index].maksConvert)}'),
                );
              },
            ),
          );
        },
        onRetry: onRetry);
  }
}
