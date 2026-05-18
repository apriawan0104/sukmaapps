import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../adapter/auth.adapter.dart';

class ButtonGoogleWidget extends StatelessWidget {
  const ButtonGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF174994),
          padding: REdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6).w),
          minimumSize: Size.fromHeight(48.h),
        ),
        onPressed: () async {
          await ref.read(authAdapterProvider.notifier).loginWithGoogle();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(IconSharedConstant.google, height: 24.h, width: 24.w),
            SizedBox(width: 8.w),
            Text(
              'Masuk Dengan Google',
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
