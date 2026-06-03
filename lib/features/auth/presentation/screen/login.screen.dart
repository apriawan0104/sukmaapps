import 'dart:io';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../widget/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D397C),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const REdgeInsets.fromLTRB(0, 16, 0, 16),
              child: ListView(
                children: [
                  UITextPrimaryWidget(
                      title: 'Sukma Convert Pulsa',
                      fontSize: 28.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      align: TextAlign.center),
                  Center(
                    child: Lottie.asset(
                      ImageLoginConstant.welcome,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          buttonBottom()
        ],
      ).withSafeArea(),
    );
  }

  Widget buttonBottom() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0D397C)),
      padding: REdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UITextPrimaryWidget(
            title: 'Tukar Pulsa Jadi Uang',
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            align: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          UITextPrimaryWidget(
            title: 'Nikmati rate tinggi dan banyak pilihan provider',
            fontSize: 14.sp,
            color: const Color(
              0xFFD1D7E0,
            ),
            fontWeight: FontWeight.w400,
            align: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          if (Platform.isIOS) ...{
            Column(
              children: [
                ButtonGoogleWidget(),
                SizedBox(height: 8.h),
                ButtonAppleWidget(),
              ],
            )
          } else ...{
            Column(
              children: [
                ButtonGoogleWidget(),
              ],
            )
          },
          SizedBox(height: 8.h),
          PrivacyPolicyWidget(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
