import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../app/app.dart';
import '../adapter/landing.adapter.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  Widget _iconNavBar(String iconName) {
    return SvgPicture.asset(
      iconName,
      width: 24.w,
      height: 24.h,
      colorFilter: ColorFilter.mode(AppColor.brPrimaryStrong, BlendMode.srcIn),
    );
  }

  BottomNavigationBarItem _navItem({
    required int index,
    required int currentIndex,
    required String label,
    required String iconBold,
    required String iconLight,
  }) {
    return BottomNavigationBarItem(
      icon: currentIndex == index
          ? _iconNavBar(iconBold)
          : _iconNavBar(iconLight),
      label: label,
    );
  }

  BottomNavigationBarItem _convertNavItem() {
    return BottomNavigationBarItem(
      icon: SizedBox(width: 48.w, height: 24.h),
      activeIcon: SizedBox(width: 48.w, height: 24.h),
      label: 'Convert',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final indexNav = ref.watch(landingRiverpodAdapterProvider).indexNav;
      final controller = ref.read(landingRiverpodAdapterProvider.notifier);
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.w, color: Colors.grey.shade300),
          ),
          color: Colors.white,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconSize: 24.w,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          selectedItemColor: AppColor.brPrimaryStrong,
          unselectedItemColor: AppColor.brPrimaryStrong,
          showUnselectedLabels: true,
          currentIndex: indexNav,
          onTap: controller.changeIndexNav,
          items: [
            _navItem(
              index: 0,
              currentIndex: indexNav,
              label: 'Beranda',
              iconBold: IconBottomNavConstant.homeBold,
              iconLight: IconBottomNavConstant.homeLight,
            ),
            _navItem(
              index: 1,
              currentIndex: indexNav,
              label: 'Riwayat',
              iconBold: IconBottomNavConstant.riwayatBold,
              iconLight: IconBottomNavConstant.riwayatLight,
            ),
            _convertNavItem(),
            _navItem(
              index: 3,
              currentIndex: indexNav,
              label: 'Info',
              iconBold: IconBottomNavConstant.infoBold,
              iconLight: IconBottomNavConstant.infoLight,
            ),
            _navItem(
              index: 4,
              currentIndex: indexNav,
              label: 'Profile',
              iconBold: IconBottomNavConstant.profileBold,
              iconLight: IconBottomNavConstant.profileLight,
            ),
          ],
        ),
      );
    });
  }
}
