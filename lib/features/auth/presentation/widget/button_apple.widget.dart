import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../adapter/auth.adapter.dart';

class ButtonAppleWidget extends StatelessWidget {
  const ButtonAppleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6).w),
          minimumSize: Size.fromHeight(48.h),
        ),
        onPressed: () async {
          await ref.read(authAdapterProvider.notifier).loginWithApple();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconSharedConstant.apple, height: 24.h, width: 24.w),
            SizedBox(width: 8.w),
            Text(
              'Masuk Dengan Apple',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    });
  }
}
