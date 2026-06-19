import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../adapter/landing.adapter.dart';
import '../controller/landing.controller.dart';

class RekeningFavPage extends ConsumerWidget {
  const RekeningFavPage({super.key});

  String _favoriteTitle(RekeningFavEntity fav) {
    if (fav.bankOptional == null) {
      return '${fav.name} - ${fav.noRekening}';
    }
    return '${fav.bankOptional} - ${fav.name} - ${fav.noRekening}';
  }

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
    required LandingController ctrl,
    required RekeningFavEntity fav,
  }) {
    return Container(
      margin: REdgeInsets.only(bottom: 8),
      child: UICardPrimaryWidget(
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
    );
  }

  Widget _sectionFavorite({
    required WidgetRef ref,
    required LandingController ctrl,
  }) {
    final rekeningFav = ref.watch(landingRiverpodAdapterProvider).rekeningFav;

    return Padding(
      padding: const REdgeInsets.all(16),
      child: AsyncValueWidget<List<RekeningFavEntity>>(
        value: rekeningFav,
        onSuccess: (items) {
          if (items.isNotEmpty) {
            return Column(
              children: List.generate(
                items.length,
                (index) => _cardFavorite(
                  ctrl: ctrl,
                  fav: items[index],
                ),
              ),
            );
          }
          return _cardEmptyFavorite();
        },
        onRetry: ctrl.getRekeningFav,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Rekening Favorit'),
      body: ListView(
        children: [
          _sectionFavorite(ref: ref, ctrl: ctrl),
        ],
      ),
    );
  }
}
