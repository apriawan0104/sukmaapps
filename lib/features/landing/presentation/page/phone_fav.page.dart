import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../adapter/landing.adapter.dart';
import '../controller/landing.controller.dart';

class PhoneFavPage extends ConsumerWidget {
  const PhoneFavPage({super.key});

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
    required LandingController ctrl,
    required String namaProvider,
    required String nomor,
    required int id,
  }) {
    return Container(
      margin: REdgeInsets.only(bottom: 16),
      child: UICardPrimaryWidget(
        width: 343.w,
        colorSide: AppColor.whiteSoft,
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
    final phoneFav = ref.watch(landingRiverpodAdapterProvider).phoneFav;

    return Padding(
      padding: const REdgeInsets.all(16),
      child: AsyncValueWidget<List<PhoneFavEntity>>(
        value: phoneFav,
        onSuccess: (items) {
          if (items.isNotEmpty) {
            return Column(
              children: List.generate(
                items.length,
                (index) => _cardFavorite(
                  ctrl: ctrl,
                  namaProvider: items[index].provider!,
                  nomor: items[index].number!,
                  id: items[index].id!,
                ),
              ),
            );
          }
          return _cardEmptyFavorite();
        },
        onRetry: ctrl.getPhoneFav,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return Scaffold(
      appBar: UIAppBar.appBar(context, title: 'Nomor Favorit'),
      body: ListView(
        children: [
          _sectionFavorite(ref: ref, ctrl: ctrl),
        ],
      ),
    );
  }
}
