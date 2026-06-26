import 'dart:io' show Platform, exit;

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/app.dart';
import '../../../core/core.dart';
import '../widget/widget.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RPadding.all(
        24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconSharedConstant.forceUpdate,
              height: 160.h,
              width: 160.w,
            ),
            SizedBox(height: 24.h),
            UITextPrimaryWidget(
              title: 'Diperlukan Pembaruan Aplikasi',
              fontSize: 16.sp,
              color: AppColor.blackMassive,
              fontWeight: FontWeight.w700,
              align: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            UITextPrimaryWidget(
              title:
                  'Untuk dapat terus menggunakan layanan kami, silakan perbarui ke versi terbaru terlebih dahulu.',
              fontSize: 14.sp,
              color: AppColor.blackMassive,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: RPadding.only(
          left: 24,
          right: 24,
          bottom: 24,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UIButtonPrimaryWidget(
                titleButton: 'Update Sekarang',
                onPressed: UriHelper.goToStore,
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: _closeApp,
                child: Text(
                  'Tutup Aplikasi',
                  style: TextStyle(
                    color: AppColor.brPrimaryStrong,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
